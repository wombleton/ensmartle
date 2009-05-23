class AddManyHerbalismSpells < ActiveRecord::Migration
  def self.up
    spells = [["2383", "Find Herbs"], ["2366", "Herb Gathering"], ["2368", "Herb Gathering"], ["3570", "Herb Gathering"], ["11993", "Herb Gathering"], ["28695", "Herb Gathering"], ["50300", "Herb Gathering"], ["55428", "Lifeblood"], ["55480", "Lifeblood"], ["55500", "Lifeblood"], ["55501", "Lifeblood"], ["55502", "Lifeblood"], ["55503", "Lifeblood"]]
    for spell in spells
      Spell.new(:spell_id => spell[0], :name => spell[1], :tradeskill => "Herbalism").save!
    end
  end
  
  def self.down
  end
end
