class Category < ActiveRecord::Base
  def tokens
    self.search.sub('"', '').split
  end
end
