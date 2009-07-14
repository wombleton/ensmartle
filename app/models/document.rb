class Document < ActiveRecord::Base
  has_many :pages, :order => :page_no

  def to_param
    "#{self.id}-#{self.name}"
  end

  def name
    self.pdf_name.split(".").first
  end

  def formatted_date
    date.strftime('%d %b %Y')
  end

  def url_date
    date.strftime('%d-%b-%Y')
  end

  def self.paginate_by_date(year, month, day, page = 1)
    conditions = [["1 = ?", 1]]
    conditions << ["YEAR(documents.date) = ?", year] if year
    conditions << ["MONTH(documents.date) = ?", month] if month
    conditions << ["DAY(documents.date) = ?", day] if day
    paginate(:all, :conditions => [conditions.transpose.first.join(' AND '), *conditions.transpose.last], :per_page => 20, :page => page, :include => :pages, :order => "documents.date desc, title")
  end
end
