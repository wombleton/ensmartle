class Document < ActiveRecord::Base
  require 'open-uri'
  require 'hpricot'
  
  has_many :pages, :order => :page_no
  validates_format_of :url, :with => /http:\/\/[a-z.]+\.govt\.nz\/.+\.pdf/, :message => "That URL looks invalid. It should be a pdf on a .govt.nz site."
  validates_uniqueness_of :url, :message => "Document has already been uploaded. Try searching for it!"

  def to_param
    "#{self.id}-#{self.name}"
  end

  def before_create
    self.pdf_name = File.basename(self.url)
  end

  def after_create
    download_document
    extract_images
    convert_to_html
    self.pages.each{|page|
      parse_sections(page)
    }
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

  private
  def download_document
    open(self.url){|f|
      pdf = File.open(pdf_path, "wb")
      pdf.write(f.read)
      pdf.close
    }
  end

  def pdf_path
    File.join(RAILS_ROOT, "files", self.pdf_name)
  end

  def image_directory
    File.join(RAILS_ROOT, "public", "images", "files")
  end

  def background_directory
    File.join(RAILS_ROOT, "public", "images", "complex")
  end

  def image_path
    File.join(image_directory, File.basename(self.pdf_name, ".pdf") + ".png")
  end

  def html_directory
    File.join(RAILS_ROOT, "files", "complex")
  end

  def extract_images
    puts `convert #{pdf_path} #{File.join(image_directory, File.basename(self.pdf_name, ".pdf") + ".png")}`

    images = Dir.glob(File.join(image_directory, File.basename(self.pdf_name, ".pdf") + "*.png"))
    images.each{|image|
      page = Page.new
      page.document = self
      page.image_path = File.join("files", File.basename(image))
      page.page_no = images.count > 1 ? File.basename(image, ".png").split("-").last.to_i : 0
      page.document = self
      page.save
    }
  end

  def convert_to_html
    self.pages.each{|page|
      no = page.number
      puts `pdftohtml -c -noframes #{pdf_path} -f #{no} -l #{no} #{File.join(html_directory, File.basename(pdf_path + "-" + no.to_s, ".pdf"))}`
    }
    puts `mv #{html_directory}/*.png #{background_directory}`
  end

  def parse_sections page
    f = File.join(html_directory, "#{self.pdf_name}-#{page.number}.html")
    content = File.open(f, "r").read
    doc = Hpricot.parse(content)
    (doc/'div div').each{|div|
      style = div.attributes['style']
      unless /^(&nbsp;|\s+)$/.match(div.inner_text)
        x, y = /left:(\d+)/.match(style)[1], /top:(\d+)/.match(style)[1]
        section = Section.new
        section.x = x
        section.y = y
        section.content = div.inner_html
        page.sections << section
      end
    }
    (doc/'div div').remove
    img = (doc/'img').first
    div = (doc/'div').first
    div.set_attribute 'style', "#{div.attributes['style']};width:#{img.attributes['width']}px;height:#{img.attributes['height']}px;background-image: url(#{'/images/complex/' + img.attributes['src']})"
    (doc/'img').remove
    page.page_html = doc.inner_html.gsub("\r"," ").gsub("\n"," ").split(" ").join(" ")
    page.save!
  end

end
