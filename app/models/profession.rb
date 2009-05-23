class Profession < ActiveRecord::Base
  attr_accessor :unlearnt_recipes
  
  belongs_to :character
  has_many :recipes, :order => :spell_id
  has_many :spells, :order => :id, :through => :recipes

  validates_presence_of :character

  def all_recipes
    spells = Spell.find(:all, :conditions => ["tradeskill = ?", self.name], :order => "id desc")
    spells.each{|s|
      s.known = self.spells.include?(s)
    }
    spells.reject{|s| s.name == self.name }
  end

  def initialize *a, &b
    super
    self.unlearnt_recipes = []
  end
end
