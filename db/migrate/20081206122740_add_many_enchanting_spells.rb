class AddManyEnchantingSpells < ActiveRecord::Migration
  def self.up
    spells = [["7411", "Enchanting"], ["13262", "Disenchant"], ["7421", "Runed Copper Rod"], ["7418", "Enchant Bracer - Minor Health"], ["7428", "Enchant Bracer - Minor Deflection"], ["14293", "Lesser Magic Wand"], ["7420", "Enchant Chest - Minor Health"], ["7443", "Enchant Chest - Minor Mana"], ["7426", "Enchant Chest - Minor Absorption"], ["25124", "Minor Wizard Oil"], ["7454", "Enchant Cloak - Minor Resistance"], ["7412", "Enchanting"], ["7457", "Enchant Bracer - Minor Stamina"], ["7766", "Enchant Bracer - Minor Spirit"], ["7748", "Enchant Chest - Lesser Health"], ["14807", "Greater Magic Wand"], ["7779", "Enchant Bracer - Minor Agility"], ["7782", "Enchant Bracer - Minor Strength"], ["7776", "Enchant Chest - Lesser Mana"], ["7771", "Enchant Cloak - Minor Protection"], ["7786", "Enchant Weapon - Minor Beastslayer"], ["7788", "Enchant Weapon - Minor Striking"], ["7795", "Runed Silver Rod"], ["7793", "Enchant 2H Weapon - Lesser Intellect"], ["7745", "Enchant 2H Weapon - Minor Impact"], ["13378", "Enchant Shield - Minor Stamina"], ["13380", "Enchant 2H Weapon - Lesser Spirit"], ["13419", "Enchant Cloak - Minor Agility"], ["13421", "Enchant Cloak - Lesser Protection"], ["13464", "Enchant Shield - Lesser Protection"], ["7859", "Enchant Bracer - Lesser Spirit"], ["7857", "Enchant Chest - Health"], ["7413", "Enchanting"], ["7867", "Enchant Boots - Minor Agility"], ["7863", "Enchant Boots - Minor Stamina"], ["7861", "Enchant Cloak - Lesser Fire Resistance"], ["13501", "Enchant Bracer - Lesser Stamina"], ["13485", "Enchant Shield - Lesser Spirit"], ["13522", "Enchant Cloak - Lesser Shadow Resistance"], ["13536", "Enchant Bracer - Lesser Strength"], ["13538", "Enchant Chest - Lesser Absorption"], ["13503", "Enchant Weapon - Lesser Striking"], ["13529", "Enchant 2H Weapon - Lesser Impact"], ["13607", "Enchant Chest - Mana"], ["13620", "Enchant Gloves - Fishing"], ["13617", "Enchant Gloves - Herbalism"], ["13612", "Enchant Gloves - Mining"], ["25125", "Minor Mana Oil"], ["13628", "Runed Golden Rod"], ["13622", "Enchant Bracer - Lesser Intellect"], ["13626", "Enchant Chest - Minor Stats"], ["14809", "Lesser Mystic Wand"], ["13635", "Enchant Cloak - Defense"], ["13631", "Enchant Shield - Lesser Stamina"], ["13637", "Enchant Boots - Lesser Agility"], ["13640", "Enchant Chest - Greater Health"], ["13642", "Enchant Bracer - Spirit"], ["13644", "Enchant Boots - Lesser Stamina"], ["13646", "Enchant Bracer - Lesser Deflection"], ["13648", "Enchant Bracer - Stamina"], ["14810", "Greater Mystic Wand"], ["13657", "Enchant Cloak - Fire Resistance"], ["13653", "Enchant Weapon - Lesser Beastslayer"], ["13655", "Enchant Weapon - Lesser Elemental Slayer"], ["13661", "Enchant Bracer - Strength"], ["13659", "Enchant Shield - Spirit"], ["13663", "Enchant Chest - Greater Mana"], ["13687", "Enchant Boots - Lesser Spirit"], ["21931", "Enchant Weapon - Winter's Might"], ["13689", "Enchant Shield - Lesser Block"], ["13693", "Enchant Weapon - Striking"], ["13920", "Enchanting"], ["25126", "Lesser Wizard Oil"], ["13702", "Runed Truesilver Rod"], ["13695", "Enchant 2H Weapon - Impact"], ["13700", "Enchant Chest - Lesser Stats"], ["13698", "Enchant Gloves - Skinning"], ["13746", "Enchant Cloak - Greater Defense"], ["13794", "Enchant Cloak - Resistance"], ["13822", "Enchant Bracer - Intellect"], ["13815", "Enchant Gloves - Agility"], ["13817", "Enchant Shield - Stamina"], ["13836", "Enchant Boots - Stamina"], ["13841", "Enchant Gloves - Advanced Mining"], ["13846", "Enchant Bracer - Greater Spirit"], ["13858", "Enchant Chest - Superior Health"], ["13890", "Enchant Boots - Minor Speed"], ["13882", "Enchant Cloak - Lesser Agility"], ["13868", "Enchant Gloves - Advanced Herbalism"], ["13887", "Enchant Gloves - Strength"], ["13917", "Enchant Chest - Superior Mana"], ["13905", "Enchant Shield - Greater Spirit"], ["13915", "Enchant Weapon - Demonslaying"], ["13935", "Enchant Boots - Agility"], ["13931", "Enchant Bracer - Deflection"], ["13933", "Enchant Shield - Frost Resistance"], ["13937", "Enchant 2H Weapon - Greater Impact"], ["13939", "Enchant Bracer - Greater Strength"], ["13945", "Enchant Bracer - Greater Stamina"], ["13941", "Enchant Chest - Stats"], ["13943", "Enchant Weapon - Greater Striking"], ["17181", "Enchanted Leather"], ["17180", "Enchanted Thorium"], ["25127", "Lesser Mana Oil"], ["13948", "Enchant Gloves - Minor Haste"], ["13947", "Enchant Gloves - Riding Skill"], ["20008", "Enchant Bracer - Greater Intellect"], ["20020", "Enchant Boots - Greater Stamina"], ["15596", "Smoking Heart of the Mountain"], ["20014", "Enchant Cloak - Greater Resistance"], ["20017", "Enchant Shield - Greater Stamina"], ["13898", "Enchant Weapon - Fiery Weapon"], ["20009", "Enchant Bracer - Superior Spirit"], ["20012", "Enchant Gloves - Greater Agility"], ["28029", "Enchanting"], ["25128", "Wizard Oil"], ["20024", "Enchant Boots - Spirit"], ["20026", "Enchant Chest - Major Health"], ["20016", "Enchant Shield - Superior Spirit"], ["20015", "Enchant Cloak - Superior Defense"], ["20029", "Enchant Weapon - Icy Chill"], ["20051", "Runed Arcanite Rod"], ["27837", "Enchant 2H Weapon - Agility"], ["23801", "Enchant Bracer - Mana Regeneration"], ["20028", "Enchant Chest - Major Mana"], ["23800", "Enchant Weapon - Agility"], ["23799", "Enchant Weapon - Strength"], ["20030", "Enchant 2H Weapon - Superior Impact"], ["20023", "Enchant Boots - Greater Agility"], ["20010", "Enchant Bracer - Superior Strength"], ["20013", "Enchant Gloves - Greater Strength"], ["20033", "Enchant Weapon - Unholy Weapon"], ["42613", "Nexus Transformation"], ["25130", "Brilliant Mana Oil"], ["25129", "Brilliant Wizard Oil"], ["32664", "Runed Fel Iron Rod"], ["20036", "Enchant 2H Weapon - Major Intellect"], ["20035", "Enchant 2H Weapon - Major Spirit"], ["34002", "Enchant Bracer - Assault"], ["23802", "Enchant Bracer - Healing Power"], ["20011", "Enchant Bracer - Superior Stamina"], ["20025", "Enchant Chest - Greater Stats"], ["33991", "Enchant Chest - Restore Mana Prime"], ["25086", "Enchant Cloak - Dodge"], ["25081", "Enchant Cloak - Greater Fire Resistance"], ["25082", "Enchant Cloak - Greater Nature Resistance"], ["25083", "Enchant Cloak - Stealth"], ["25084", "Enchant Cloak - Subtlety"], ["25078", "Enchant Gloves - Fire Power"], ["25074", "Enchant Gloves - Frost Power"], ["25079", "Enchant Gloves - Healing Power"], ["25073", "Enchant Gloves - Shadow Power"], ["25080", "Enchant Gloves - Superior Agility"], ["25072", "Enchant Gloves - Threat"], ["20034", "Enchant Weapon - Crusader"], ["22750", "Enchant Weapon - Healing Power"], ["20032", "Enchant Weapon - Lifestealing"], ["23804", "Enchant Weapon - Mighty Intellect"], ["23803", "Enchant Weapon - Mighty Spirit"], ["22749", "Enchant Weapon - Spell Power"], ["20031", "Enchant Weapon - Superior Striking"], ["27948", "Enchant Boots - Vitality"], ["27899", "Enchant Bracer - Brawn"], ["34001", "Enchant Bracer - Major Intellect"], ["33993", "Enchant Gloves - Blasting"], ["28016", "Superior Mana Oil"], ["34004", "Enchant Cloak - Greater Agility"], ["27961", "Enchant Cloak - Major Armor"], ["33996", "Enchant Gloves - Assault"], ["27944", "Enchant Shield - Tough Shield"], ["27905", "Enchant Bracer - Stats"], ["27957", "Enchant Chest - Exceptional Health"], ["27950", "Enchant Boots - Fortitude"], ["27906", "Enchant Bracer - Major Defense"], ["33990", "Enchant Chest - Major Spirit"], ["28027", "Prismatic Sphere"], ["27911", "Enchant Bracer - Superior Healing"], ["34003", "Enchant Cloak - Spell Penetration"], ["27945", "Enchant Shield - Intellect"], ["34009", "Enchant Shield - Major Stamina"], ["27962", "Enchant Cloak - Major Resistance"], ["44383", "Enchant Shield - Resilience"], ["28022", "Large Prismatic Shard"], ["42615", "Small Prismatic Shard"], ["27913", "Enchant Bracer - Restore Mana Prime"], ["28019", "Superior Wizard Oil"], ["27951", "Enchant Boots - Dexterity"], ["33995", "Enchant Gloves - Major Strength"], ["27946", "Enchant Shield - Shield Block"], ["27968", "Enchant Weapon - Major Intellect"], ["27967", "Enchant Weapon - Major Striking"], ["27960", "Enchant Chest - Exceptional Stats"], ["33992", "Enchant Chest - Major Resilience"], ["51313", "Enchanting"], ["46578", "Enchant Weapon - Deathfrost"], ["42620", "Enchant Weapon - Greater Agility"], ["60609", "Enchant Cloak - Speed"], ["28028", "Void Sphere"], ["32665", "Runed Adamantite Rod"], ["27971", "Enchant 2H Weapon - Savagery"], ["27914", "Enchant Bracer - Fortitude"], ["34005", "Enchant Cloak - Greater Arcane Resistance"], ["34006", "Enchant Cloak - Greater Shadow Resistance"], ["33999", "Enchant Gloves - Major Healing"], ["34010", "Enchant Weapon - Major Healing"], ["27975", "Enchant Weapon - Major Spellpower"], ["27972", "Enchant Weapon - Potency"], ["27977", "Enchant 2H Weapon - Major Agility"], ["34008", "Enchant Boots - Boar's Speed"], ["34007", "Enchant Boots - Cat's Swiftness"], ["33997", "Enchant Gloves - Major Spellpower"], ["33994", "Enchant Gloves - Precise Strikes"], ["27924", "Enchant Ring - Spellpower"], ["27920", "Enchant Ring - Striking"], ["27947", "Enchant Shield - Resistance"], ["28004", "Enchant Weapon - Battlemaster"], ["28003", "Enchant Weapon - Spellsurge"], ["60616", "Enchant Bracers - Striking"], ["44592", "Enchant Gloves - Exceptional Spellpower"], ["27917", "Enchant Bracer - Spellpower"], ["46594", "Enchant Chest - Defense"], ["27954", "Enchant Boots - Surefooted"], ["27926", "Enchant Ring - Healing Power"], ["44623", "Enchant Chest - Super Stats"], ["45765", "Void Shatter"], ["27981", "Enchant Weapon - Sunfire"], ["32667", "Runed Eternium Rod"], ["44506", "Enchant Gloves - Gatherer"], ["47051", "Enchant Cloak - Steelweave"], ["27927", "Enchant Ring - Stats"], ["42974", "Enchant Weapon - Executioner"], ["27984", "Enchant Weapon - Mongoose"], ["27982", "Enchant Weapon - Soulfrost"], ["44555", "Enchant Bracers - Exceptional Intellect"], ["60606", "Enchant Boots - Assault"], ["60621", "Enchant Weapon - Greater Potency"], ["44528", "Enchant Boots - Greater Fortitude"], ["60623", "Enchant Boots - Icewalker"], ["44630", "Enchant 2H Weapon - Greater Savagery"], ["44582", "Enchant Cloak - Spell Piercing"], ["44635", "Enchant Bracers - Greater Spellpower"], ["44492", "Enchant Chest - Mighty Health"], ["44500", "Enchant Cloak - Superior Agility"], ["44513", "Enchant Gloves - Greater Assault"], ["60653", "Enchant Shield - Greater Intellect"], ["44629", "Enchant Weapon - Exceptional Spellpower"], ["44645", "Enchant Ring - Assault"], ["44636", "Enchant Ring - Greater Spellpower"], ["59636", "Enchant Ring - Stamina"], ["44616", "Enchant Bracers - Greater Stats"], ["47766", "Enchant Chest - Greater Defense"], ["44556", "Enchant Cloak - Superior Fire Resistance"], ["44483", "Enchant Cloak - Superior Frost Resistance"], ["44494", "Enchant Cloak - Superior Nature Resistance"], ["44590", "Enchant Cloak - Superior Shadow Resistance"], ["44584", "Enchant Boots - Greater Vitality"], ["44484", "Enchant Gloves - Expertise"], ["44508", "Enchant Boots - Greater Spirit"], ["44488", "Enchant Gloves - Precision"], ["44633", "Enchant Weapon - Exceptional Agility"], ["44510", "Enchant Weapon - Exceptional Spirit"], ["44589", "Enchant Boots - Superior Agility"], ["44598", "Enchant Bracers - Expertise"], ["44529", "Enchant Gloves - Major Agility"], ["44593", "Enchant Bracers - Major Spirit"], ["44509", "Enchant Chest - Greater Mana Restoration"], ["60663", "Enchant Cloak - Major Agility"], ["44489", "Enchant Shield - Defense"], ["60619", "Runed Titanium Rod"], ["47900", "Enchant Chest - Super Health"], ["60668", "Enchant Gloves - Crusher"], ["44524", "Enchant Weapon - Icebreaker"], ["60691", "Enchant 2H Weapon - Massacre"], ["44595", "Enchant 2H Weapon - Scourgebane"], ["44575", "Enchant Bracers - Greater Assault"], ["47898", "Enchant Cloak - Greater Speed"], ["47672", "Enchant Cloak - Mighty Armor"], ["44621", "Enchant Weapon - Giant Slayer"], ["44591", "Enchant Cloak - Titanweave"], ["44625", "Enchant Gloves - Armsman"], ["60714", "Enchant Weapon - Mighty Spellpower"], ["60707", "Enchant Weapon - Superior Potency"], ["60763", "Enchant Boots - Greater Assault"], ["47901", "Enchant Boots - Tuskarr's Vitality"], ["60767", "Enchant Bracers - Superior Spellpower"], ["60692", "Enchant Chest - Powerful Stats"], ["44631", "Enchant Cloak - Shadow Armor"], ["47899", "Enchant Cloak - Wisdom"], ["59619", "Enchant Weapon - Accuracy"], ["59621", "Enchant Weapon - Berserking"], ["59625", "Enchant Weapon - Black Magic"], ["44576", "Enchant Weapon - Lifeward"], ["44612", "Enchant Gloves - Greater Blasting"], ["44596", "Enchant Cloak - Superior Arcane Resistance"], ["44588", "Enchant Chest - Exceptional Resilience"]]
    for spell in spells
      Spell.new(:spell_id => spell[0], :name => spell[1], :tradeskill => "Enchanting").save!
    end
  end
  
  def self.down
  end
end
