class Game < ActiveRecord::Base
  has_many :missions
  validates_uniqueness_of :permalink
  
  CHARACTERS = ((0..9).to_a + ('a'..'z').to_a + ('A'..'Z').to_a).flatten

  def to_param
    permalink
  end

  def generate_permalink num
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

  def after_create
    if permalink.nil?
      self.permalink = generate_permalink self.created_at.hash
      self.save
    end
  end
end
