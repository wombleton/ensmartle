class Tweet < ActiveRecord::Base
  attr_accessor :to_user
  validates_uniqueness_of :original
  
  def summarise(token)
    words = self.text.split
    i = words.map{|w|
      w.downcase
    }.index(token.downcase)
    i = 0 if i.nil?
    start = i - 3
    finish = i + 3
    if start < 0
      finish - start
      start = 0
    end
    words.slice(start..finish).join(' ')
  end
end
