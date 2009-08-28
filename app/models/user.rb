class User < ActiveRecord::Base
  acts_as_authentic

  has_many :sheets

  def has_role?
    self.gm? or self.player?
  end
end
