class Block < ActiveRecord::Base
  belongs_to :user
  belongs_to :twit, :class_name => "User"
end
