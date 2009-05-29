class Game < ActiveRecord::Base
  has_many :missions
  validates_uniqueness_of :permalink
  
  def to_param
    permalink
  end

  def after_create
    if permalink.nil?
      self.permalink = (self.id * self.created_at.hash).base62
      self.save
    end
  end
end
