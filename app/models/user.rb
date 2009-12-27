class User < ActiveRecord::Base
  has_many :sheets
  has_many :blocks
  has_many :twits, :through => :blocks

  def to_param
    self.screen_name.parameterize
  end

  def has_role?
    self.gm? or self.player?
  end

  def should_block? twit
    if stance == "aggressive" or stance == "conservative"
      twit.tweetblocker_rating == "F"
    else
      false
    end
  end

  def manage_block twit
    if self.twits.include?(twit)
      unless self.should_block?(twit)
        twitter.unblock twit.screen_name
        Block.destroy_all(:twit => twit, :user => self)
      end
    else
      if self.should_block?(twit)
        twitter.block twit.screen_name
        Block.create(:user => self, :twit => twit)
      end
    end
  end

  class << self
    def mentions
      since = User.maximum('last_tweet_id')
      User.oauthed.in_groups_of(50).inject([]){|mentions, users|
        mentions << Twitter::Search.new(users.map{|u| "to:#{u.screen_name}"}.join(" OR "), :per_page => 200, :since => since).fetch
      }.flatten
    end

    def oauthed
      User.find(:all, :conditions => "atoken IS NOT NULL AND asecret IS NOT NULL", :include => :twits)
    end

    def twits
      User.mentions.each{|m|
        User.fetch m.from
      }
      User.find(:all, :conditions => ["tweetblocker_rating = ? OR bad_url = ?", "F", true])
    end

    def sweep
      twits = User.twits

      User.oauthed.each{|user|
        twits.each{|twit|
          user.manage_block(twit)
        }
        rescue_from Twitter::Unauthorized do
          continue
        end
      }
    end

    def fetch screen_name
      @user = User.find_or_create_by_screen_name(screen_name) {|u|
        profile = Twitter.user screen_name
        u.profile_image_url = profile.profile_image_url
        u.url = profile.url
        u.name = profile.name
        u.last_tweet_id = profile.last_status
      }
    end
  end

  private
  def twitter
    @oauth ||= Twitter::OAuth.new(ConsumerConfig['token'], ConsumerConfig['secret'])
    @oauth.authorize_from_access(self.atoken, self.asecret) if self.atoken and self.asecret
    @twitter ||= Twitter::Base.new(@oauth)
  end
end
