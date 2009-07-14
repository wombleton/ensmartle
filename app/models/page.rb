class Page < ActiveRecord::Base
  belongs_to :document
  has_many :sections, :order => "position"

  acts_as_ferret :fields => [:keywords]
  
  def to_param
    "#{self.id}-#{self.document.name}-p#{self.page_no + 1}"
  end

  def next_page
    (self.number < self.count) ? self.document.pages.find_by_page_no(self.number) : nil
  end

  def previous_page
    (self.number > 1) ? self.document.pages.find_by_page_no(self.page_no - 1) : nil
  end

  def number
    self.page_no + 1
  end

  def count
    self.document.pages.count
  end

end
