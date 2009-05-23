class CreateSockpuppets < ActiveRecord::Migration
  SOCKPUPPETS = %w(Auckland NZSportNews AucklandNZ decision08 newstalkzb NZStuffVote08 3NewsNZ NationalParty NZBreakingNews nzheraldnat nzpolitics rnz_election08 dompost napiernews nzhelection08 nzgreenparty ONENews nzstuffbusiness nzstuff nzherald rnz_news TVNZNews QueenstownNZ NewGreenStuff bitsontheside Hitwise_AP trendingtopics wellingtonnz newzealandnews nzfirst election_melee whatchathink whaleoil bigidea).map{|s| s.downcase}

  def self.up
    create_table :sockpuppets do |t|
      t.string :screen_name
      
      t.timestamps
    end
    
    
    SOCKPUPPETS.each{|s|
      Sockpuppet.new(:screen_name => s).save
    }
  end
  
  def self.down
    drop_table :sockpuppets
  end
end
