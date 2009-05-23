class Component < ActiveRecord::Base
  belongs_to :item
  belongs_to :reagent, :class_name => 'Item'
end
