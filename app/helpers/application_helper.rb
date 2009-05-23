# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def character_path character
    url_for :controller => "characters", :action => "show", :id => character, :realm_id => character.realm
  end
end

class String
 def sanitise
   self.gsub(/'/, '').gsub(/[^a-zA-Z0-9\-]/, '-').tr_s('-', '-').gsub(/^-/, '').gsub(/-$/, '').downcase
 end
end
