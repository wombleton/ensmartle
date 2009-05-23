class AddManyMiningSpells < ActiveRecord::Migration
  def self.up
    spells = [["2580", "Find Minerals"], ["2575", "Mining"], ["2656", "Smelting"], ["2657", "Smelt Copper"], ["2576", "Mining"], ["3304", "Smelt Tin"], ["2659", "Smelt Bronze"], ["2658", "Smelt Silver"], ["3564", "Mining"], ["3307", "Smelt Iron"], ["3308", "Smelt Gold"], ["3569", "Smelt Steel"], ["10097", "Smelt Mithril"], ["10248", "Mining"], ["10098", "Smelt Truesilver"], ["14891", "Smelt Dark Iron"], ["16153", "Smelt Thorium"], ["29354", "Mining"], ["35750", "Earth Shatter"], ["35751", "Fire Sunder"], ["29356", "Smelt Fel Iron"], ["22967", "Smelt Elementium"], ["29358", "Smelt Adamantite"], ["50310", "Mining"], ["29359", "Smelt Eternium"], ["29360", "Smelt Felsteel"], ["49252", "Smelt Cobalt"], ["46353", "Smelt Hardened Khorium"], ["29361", "Smelt Khorium"], ["29686", "Smelt Hardened Adamantite"], ["49258", "Smelt Saronite"], ["55211", "Smelt Titanium"], ["55208", "Smelt Titansteel"], ["53120", "Toughness"], ["53121", "Toughness"], ["53122", "Toughness"], ["53123", "Toughness"], ["53124", "Toughness"], ["53040", "Toughness"]]
    for spell in spells
      Spell.new(:spell_id => spell[0], :name => spell[1], :tradeskill => "Mining").save!
    end
  end
  
  def self.down
  end
end
