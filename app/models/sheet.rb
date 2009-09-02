class Sheet < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name, :user

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
