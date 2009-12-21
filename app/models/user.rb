class User < ActiveRecord::Base
  has_many :sheets

  def to_param
    self.screen_name.parameterize
  end

  def has_role?
    self.gm? or self.player?
  end
end
