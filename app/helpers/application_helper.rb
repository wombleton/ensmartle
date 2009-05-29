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

class Bignum
 CHARACTERS = ((0..9).to_a + ('a'..'z').to_a + ('A'..'Z').to_a).flatten
 def base62
    num = self
    len = CHARACTERS.length
    result = []
    while num >= len
      result << CHARACTERS[num % len]
      num = num / len
    end
    result << CHARACTERS[num]

    link = result.reverse.join('')
    link
 end
end
