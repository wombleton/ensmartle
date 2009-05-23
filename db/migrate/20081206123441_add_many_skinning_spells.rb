class AddManySkinningSpells < ActiveRecord::Migration
  def self.up
    spells = [["8613", "Skinning"], ["8617", "Skinning"], ["8618", "Skinning"], ["10768", "Skinning"], ["32678", "Skinning"], ["50305", "Skinning"], ["53125", "Master of Anatomy"], ["53662", "Master of Anatomy"], ["53663", "Master of Anatomy"], ["53664", "Master of Anatomy"], ["53665", "Master of Anatomy"], ["53666", "Master of Anatomy"]]
    for spell in spells
      Spell.new(:spell_id => spell[0], :name => spell[1], :tradeskill => "Skinning").save!
    end
  end
  
  def self.down
  end
end
