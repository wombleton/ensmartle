class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.validate_password_field = false
    c.validate_login_field = false
    c.validate_email_field = false
  end
  validates_presence_of :openid_identifier

  has_many :sheets

  def has_role?
    self.gm? or self.player?
  end
end
