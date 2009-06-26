class Document < ActiveRecord::Base
  has_many :pages, :order => :page_no

  def to_param
    "#{self.id}-#{self.name}"
  end

  def name
    self.pdf_name.split(".").first
  end
end
