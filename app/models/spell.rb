class Spell < ActiveRecord::Base
  attr_accessor :known
  has_many :recipes
  has_many :professions, :through => :recipes

  validates_presence_of :name, :tradeskill

  def to_param
    "#{self.id}-#{self.name.sanitise}"
  end
end
