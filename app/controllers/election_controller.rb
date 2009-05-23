class ElectionController < ApplicationController
#  require 'rest-open-uri'
  USERNAME = 'election_melee'
  PASS = 'weMIGHTrock'
  
  CACHED_LOCATIONS = {}
  
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper
  
  def index
    update
    get_tweets
  end
  
  def rss
    @tz = TZInfo::Timezone.get('Pacific/Auckland')
    update
    get_tweets 100
    render :layout => false
    headers["Content-Type"] = "application/xml; charset=utf-8"
  end
  
  def process_json json, category
    tweets = ActiveSupport::JSON.decode(json)['results']
    tweets.reject!{|t|
      @sockpuppets.detect{|s| s == t['from_user'].downcase} or not Tweet.find_by_original(t['id']).nil?
    }
    
    relevant = []
    tweets.reverse!
    
    for t in tweets
      original = t['id']
      
      t.delete 'id'
      tweet = Tweet.new(t)
      tweet.original = original
      tweet.created_at = tweet.created_at
      
      if not category.location_aware 
        relevant << tweet
      else
        profile = fetch_profile(tweet.from_user)
        if profile.nil?
          break
        end
        if /New Zealand/.match(profile.mapped_location) and category.tokens.select{|tok| Regexp.new(tok).match(tweet.text) }.length == category.tokens.length
          relevant << tweet
        end
      end
    end
    return relevant
  end
  
  private
  def save_tweet(tweet, category)
    tweet.save
    if ENV['RAILS_ENV'] == 'production'
      post tweet, category
    else
      logger.info "NZ Election tweeton: #{tweet.summarise category.tokens.first} ... http://www.twitter.com/#{tweet.from_user}/statuses/#{tweet.original}"
    end
  end
  
  def post(tweet, category)
    url = URI.parse('http://twitter.com/statuses/update.json')
    
    req = Net::HTTP::Post.new(url.path)
    req.basic_auth USERNAME, PASS
    req.set_form_data({'status' => "NZ Election tweeton: http://www.twitter.com/#{tweet.from_user}/statuses/#{tweet.original} ... #{tweet.summarise category.tokens.first} ..."})
    
    begin
      res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
      
      case res
        when Net::HTTPSuccess, Net::HTTPRedirection
        if res.body.empty?
          logger.error "Twitter is not responding properly"
        else
          logger.info "Twitter update succeeded"
        end
        
      else
        logger.error " Twitter update failed for an unknown reason"
        res.error!
      end
      
    rescue
      logger.error "Twitter update failed - check username/password"
    end
    
  rescue => e
    logger.error e.message
  end
  
  def get_tweets(limit = 20)
    if params[:since].nil?
      @tweets = Tweet.find(:all, :order => 'original desc', :limit => limit, :conditions => ['lower(from_user) NOT IN (?)', @sockpuppets])
    else
      previous = Tweet.find_by_original(params[:since])
      @tweets = Tweet.find(:all, :order => 'original desc', :limit => limit, :conditions => ['created_at > ? AND lower(from_user) NOT IN (?)', previous.nil? ? 0 : previous.created_at, @sockpuppets])
    end
  end
  
  def update
    @sockpuppets = Sockpuppet.find(:all).map{|s| s.screen_name.downcase }
    begin 
      category = Category.find(:all, :limit => 1, :order => "scan_count, search").first
      logger.info "Category retrieved: #{category.search}"
      updated_at = category.updated_at
      category.scan_count = category.scan_count + 1
      category.save
      if not updated_at.nil? and Time.new - updated_at < 120
        return
      end
      
      # open-uri RDoc: http://stdlib.rubyonrails.org/libdoc/open-uri/rdoc/index.html
      url = URI.encode("http://search.twitter.com/search.json?q=#{category.search}&rpp=100&since_id=#{category.latest || ''}")
      begin
        json = open(url, :http_basic_authentication=>[USERNAME, PASS]).read
      rescue => e
        logger.error "Couldn't open json for search #{e.inspect}"
      end
      json.gsub!(/"text":"(\d{4}-\d{2}-\d{2})/, "\"text\":\"\1") #bugfix for starting string with date ... !?
      
      relevant = process_json json, category
      relevant.each{|r|
        save_tweet r, category
        category.latest = r.original
      }
      
      category.save
    rescue Exception => e
      logger.error("There was a problem: #{e.inspect}")
    end
  end
  
  def fetch_profile(screen_name)
    p = Profile.find_by_screen_name(screen_name)
    if p.nil?
      url = URI.encode("http://twitter.com/users/show/#{screen_name}.json")
      begin
        json = open(url, :http_basic_authentication => [USERNAME, PASS]).read
      rescue => e
        logger.error "Couldn't open profile #{url} #{e.inspect}"
        return nil
      end
      profile = ActiveSupport::JSON.decode(json)
      profile.delete 'id'
      if not profile['location'].nil?
        mapped_location = CACHED_LOCATIONS[profile['location']] || fetch_location(profile['location'])
      end
      p = Profile.new(:screen_name => profile['screen_name'], :location => profile['location'], :mapped_location => mapped_location || '')
      unless p.save
        logger.error "Couldn't save this profile: #{p.errors.inspect}"
      end
    end
    
    return p
  end
  
  def fetch_location(location)
    maps_json = open(URI.encode("http://maps.google.com/maps/geo?output=json&oe=utf-8&q=#{location}"), "User-Agent" => "Ruby/#{RUBY_VERSION}").read
    mapped = ActiveSupport::JSON.decode(maps_json)
    begin
      mapped_location = mapped['Placemark'][0]['AddressDetails']['Country']['CountryName']
    rescue
      begin
        mapped_location = mapped['name']
      rescue
        #do nothing
      end
    end
    if not mapped_location.nil?
      CACHED_LOCATIONS[location] = mapped_location
    end
    return mapped_location
  end
end
