class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :search
      t.integer :latest
      
      t.timestamps
    end
    
    phrases = ["\"helen clark\"",
    "\"john key\"",
    "#nzdebate",
    "#nzelection",
    "\"nz election\"",
    "\"green party\" nz",
    "\"labour party\" nz",
    "national nz",
    "\"maori party\"",
    "\"nz first\"",
    "\"united future\" nz",
    "\"pita sharples\"",
    "\"tariana turia\"",
    "\"winston peters\"",
    "\"michael cullen\"",
    "\"bill english\"",
    "\"jeanette fitzsimons\""]
    
    phrases.each{|p|
      c = Category.new
      c.search = p
      c.save
    }
  end

  def self.down
    drop_table :categories
  end
end
