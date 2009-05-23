class MoveLocaleToRealm < ActiveRecord::Migration
  def self.up
    add_column :realms, :locale, :string

    Character.find(:all).each{|c|
      if c.realm.locale.nil?
        c.realm.locale ||= c.locale
        c.realm.save
      end
    }
    remove_column :characters, :locale
  end

  def self.down
    remove_column :realms, :locale
    add_column :characters, :locale
  end
end