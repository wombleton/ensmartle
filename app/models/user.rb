class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.validate_password_field = false
    c.openid_required_fields = [:nickname, :email]
  end
  validates_presence_of :openid_identifier

  def map_openid_registration(registration)
    self.email = registration["email"] if email.blank?
    self.login = registration["nickname"] if login.blank?
  end

  has_many :sheets

  def to_param
    self.login.parameterize
  end

  def has_role?
    self.gm? or self.player?
  end
end
