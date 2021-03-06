class Mission < ActiveRecord::Base
  belongs_to :game
  has_many :events, :order => "updated_at"

  def to_param
    permalink
  end

  def after_create
    if permalink.nil?
      self.permalink = "#{(self.id * self.created_at.hash).base62}"
      self.save
    end
  end
end
