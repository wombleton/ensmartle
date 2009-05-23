class AddManyFishingSpells < ActiveRecord::Migration
  def self.up
    spells = [["7620", "Fishing"], ["7731", "Fishing"], ["43308", "Find Fish"], ["7732", "Fishing"], ["18248", "Fishing"], ["33095", "Fishing"], ["51294", "Fishing"]]
    for spell in spells
      Spell.new(:spell_id => spell[0], :name => spell[1], :tradeskill => "Fishing").save!
    end
  end
  
  def self.down
  end
end
