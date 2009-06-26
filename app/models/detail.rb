class Detail < ActiveRecord::Base
  belongs_to :page

  validates_presence_of :comment
end
