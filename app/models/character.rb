class Character < ActiveRecord::Base
  has_many :professions, :order => :name
  has_many :recipes, :through => :professions
  belongs_to :realm

  validates_presence_of :name, :realm

  before_save :update_pseudo_id

  def self.locate realm_id, character_id
    realm = Realm.find_by_pseudo_id(realm_id)
    character = Character.find_by_name(character_id, :include => :professions, :conditions => {:realm_id => realm.id})
  end

  def update_professions
    api = Wowr::API.new(:caching => false, :locale => self.realm.locale.downcase)
    api_character = api.get_character(self.name, :realm => self.realm.name, :lang => 'en')
    for p in api_character.professions
      unless self.professions.detect{|model_prof| model_prof.name == p.name}
        self.professions << Profession.new(:character_id => self.id, :name => p.name, :max => p.max, :value => p.value)
      end
    end
    self.name = api_character.name
    self.guild = api_character.guild
    self.save!
  end

  def learn_spell spell
    profession = self.professions.detect{|p| 
      p.name == spell.tradeskill
    }
    unless profession.nil?
      recipe = Recipe.new(:spell => spell, :profession => profession)
      recipe.save
      recipe
    end
  end

  def forget_spell spell
    profession = self.professions.detect{|p|
      p.name == spell.tradeskill
    }
    unless profession.nil?
      recipe = Recipe.find_by_spell_and_profession(spell, profession)
      recipe.destroy
    end
  end

  def to_param
    self.pseudo_id
  end

  def update_pseudo_id
    self.pseudo_id = name.sanitise
  end
end
