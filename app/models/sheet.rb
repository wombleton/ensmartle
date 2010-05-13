class Sheet < ActiveRecord::Base
  belongs_to :user
  has_one :user, :foreign_key => :latest_sheet_id

  validates_presence_of :name, :user_id

  def to_param
    "#{self.id}-#{self.name.parameterize}"
  end

  def display_text
    "#{self.name} (#{self.sheet_type})"
  end

  def sheet_type
    player? ? "Player" : "NPC"
  end
end
