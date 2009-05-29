class Roll < ActiveRecord::Base
  belongs_to :mission

  def dice
    self.value.split(//).map(&:to_i)
  end

  def dice= dice
    self.number = dice.to_i
    values = []
    self.number.to_i.times{ values << roll_one}
    values.sort!{|a, b| a.to_i <=> b.to_i}
    self.value = values.join('')
  end

  def roll_one
    rand(6) + 1
  end

  def explode!
    values = dice
    values.each{|d|
      values << roll_one if d == 6
    }
    self.value = values.join('')
    self.update_attributes({
        :exploded => true,
        :value => values.join('')
    })
  end

  def explodable?
    not exploded? and dice.include?(6)
  end

  def successes
    dice.select{|d| d >= 4}.length
  end
end
