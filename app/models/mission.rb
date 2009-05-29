class Mission < ActiveRecord::Base
  belongs_to :game
  has_many :rolls, :order => "created_at desc"
end
