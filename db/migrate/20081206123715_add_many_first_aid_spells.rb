class AddManyFirstAidSpells < ActiveRecord::Migration
  def self.up
    spells = [["3273", "First Aid"], ["3275", "Linen Bandage"], ["3276", "Heavy Linen Bandage"], ["3274", "First Aid"], ["7934", "Anti-Venom"], ["3277", "Wool Bandage"], ["3278", "Heavy Wool Bandage"], ["7924", "First Aid"], ["7935", "Strong Anti-Venom"], ["7928", "Silk Bandage"], ["7929", "Heavy Silk Bandage"], ["10846", "First Aid"], ["10840", "Mageweave Bandage"], ["10841", "Heavy Mageweave Bandage"], ["18629", "Runecloth Bandage"], ["18630", "Heavy Runecloth Bandage"], ["27028", "First Aid"], ["23787", "Powerful Anti-Venom"], ["27032", "Netherweave Bandage"], ["45542", "First Aid"], ["45545", "Frostweave Bandage"], ["27033", "Heavy Netherweave Bandage"], ["45546", "Heavy Frostweave Bandage"]]
    for spell in spells
      Spell.new(:spell_id => spell[0], :name => spell[1], :tradeskill => "First Aid").save!
    end
  end
  
  def self.down
  end
end
