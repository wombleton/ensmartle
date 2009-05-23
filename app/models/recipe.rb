class Recipe < ActiveRecord::Base
  belongs_to :profession
  belongs_to :spell

  validates_presence_of :profession, :spell
end
