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

  def block_twit twit
    twitter.block twit.screen_name if twitter
    Block.create(:user => self, :twit => twit)
  end

  def after_create

  end

  class << self
    def twits
      User.find(:all, :conditions => ["tweetblocker_rating = ? OR bad_url = ?", "F", true])
    end

    def sweep
      @@twits = User.twits.inject({}){|hash, twit|
        hash[twit.user_name] = twit
      }

      users = User.find(:all, :include => :twits)

      User.mentions(users).each{|m|
        @@twits[m.from_user] = Twit.fetch(m.from_user) unless @@twits.has_key?(m.from_user)
      }

      users.each{|user|
        @@twits.keys.each{|twit|
          user.block_twit(twit) if user.needs_block?(twit)
        }
      }
    end

    def fetch screen_name
      profile = Twitter.user screen_name
      @user = User.find_or_create_by_screen_name(screen_name) {|u|
        u.profile_image_url = profile.profile_image_url
        u.url = profile.url
        u.name = profile.name
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
