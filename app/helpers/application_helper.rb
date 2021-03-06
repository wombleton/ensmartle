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

CHARACTERS = ((0..9).to_a + ('a'..'z').to_a + ('A'..'Z').to_a).flatten
class Bignum
  def base62
    num = self.abs
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
class Fixnum
  def base62
    num = self.abs
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
def menu(&block)
  @menu_items ||= []
  @menu_items << capture(&block)
end

module ActsAsFerret
  module ClassMethods
    def paginate_search(query, options = {})
      page, per_page, total = wp_parse_options(options)
      pager = WillPaginate::Collection.new(page, per_page, total)
      options.merge!(:offset => pager.offset, :limit => per_page)
      result = find_with_ferret(query, options)
      returning WillPaginate::Collection.new(page, per_page, result.total_hits) do |pager|
        pager.replace result
      end
    end
  end
end
