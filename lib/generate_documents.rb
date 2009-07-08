require 'rubygems'
require 'open-uri'
require 'hpricot'

class GenerateDocuments
  URLS = %W(http://www.treasury.govt.nz/publications/informationreleases/budget/2009/key http://www.treasury.govt.nz/publications/informationreleases/budget/2009/bilateral http://www.treasury.govt.nz/publications/informationreleases/budget/2009/letters http://www.treasury.govt.nz/publications/informationreleases/budget/2009/supportparty http://www.treasury.govt.nz/publications/informationreleases/budget/2009/cabinetminutes http://www.treasury.govt.nz/publications/informationreleases/budget/2009/fiscalstrategy http://www.treasury.govt.nz/publications/informationreleases/budget/2009/tax http://www.treasury.govt.nz/publications/informationreleases/budget/2009/linebylinereviews http://www.treasury.govt.nz/publications/informationreleases/budget/2009/informationrelease)
  def download
    URLS.each{|url|
      download_page url
    }
  end

  def download_page url
    doc = Hpricot open(url)
    rows = (doc/('table.gallery tbody tr'))
    rows.each{|r|
      doc_url = "http://www.treasury.govt.nz" + r.at('td[4] a').attributes['href']
      pdf_name = doc_url.split("/").last
      document = Document.find_or_initialize_by(pdf_name)
      document.date = Date.parse(r.at('td[1]').inner_html)
      document.document_type = r.at('td[2]').inner_html
      document.title = r.at('td[3]').inner_html.gsub(/(<em>.+<\/em>)|(<br \/>)/, '')
      document.url = doc_url
      document.save!
      convert_document document
    }
  end

  def convert_document document
    puts `convert #{document.url} #{File.join(RAILS_ROOT, "files", File.basename(document.pdf_name, ".pdf") + ".png")}`
    images = Dir.glob(File.join(RAILS_ROOT, "public", "images", "files", File.basename(document.pdf_name, ".pdf") + "*.png"))
    images.each{|image|
      page = Page.new
      page.document = document
      page.image_path = File.join("files", File.basename(image))
      page.page_no = File.basename(image, ".png").split("-").last.to_i
      page.save!
    }
  end

  def download_pdfs
    URLS.each{|url|
      doc = Hpricot open(url)
      rows = (doc/('table.gallery tbody tr'))
      rows.each{|r|
        url = "http://www.treasury.govt.nz" + r.at('td[4] a').attributes['href']
        puts "Opening #{url}"
        open(url){|f|
          pdf = File.open(File.join(RAILS_ROOT, "files", File.basename(url)), "wb")
          pdf.write(f.read)
          pdf.close
          puts "Successfully written to #{pdf}"
        }
      }
    }
  end

  def convert_pdfs
    Page.find(:all).each{|page|
      f = File.join(RAILS_ROOT, "files", page.document.pdf_name)
      no = page.number
      puts `pdftohtml -c -noframes #{f} -f #{no} -l #{no} #{File.join(RAILS_ROOT, "files", "complex", File.basename(f + "-" + no.to_s, ".pdf"))}`
    }
  end

  def hoover_up_html
    Page.find(:all).each{|page|
      f = File.join(RAILS_ROOT, "files", "output2", "#{page.document.pdf_name}-#{page.number}.html")
      content = File.open(f, "r").read
      doc = Hpricot.parse(content)
      page.page_html = (doc/'body').to_html
      page.save
      puts "#{page.id} hoovered up ... #{page.page_html.length} characters!"
    }
  end

  def parse_page_parts page
    f = File.join(RAILS_ROOT, "files", "complex", "#{page.document.pdf_name}-#{page.number}.html")
    content = File.open(f, "r").read
    doc = Hpricot.parse(content)
    (doc/'div').each{|div|
      unless div.inner_html.strip.empty?
        style = div.attributes['style']
        unless /position:relative/.match(style)
          x, y = /top:(\d+)/.match(style)[1], /left:(\d+)/.match(style)[1]
          section = Section.new
          section.page = page
          section.x = x
          section.y = y
        end
      end
    }
  end

  def parse_xml
    files = Dir.glob(File.join(RAILS_ROOT, "files", "output", "*.xml"))
    puts "#{files.count} files found."
    files.each{|file|
      content = File.open(file, "r").read
      doc = Hpricot.parse(content)
      pages = doc.search('/*/page')
      pdf_name = File.basename(file, ".xml") + ".pdf"
      puts pdf_name
      document = Document.find_by_pdf_name(pdf_name)
      pages.each{|p|
        number = p.attributes['number']
        page = Page.find(:first, :conditions => {:page_no => (number.to_i - 1), :document_id => document.id})
        puts "Page missing: #{document.pdf_name} p#{number}" if page.nil?
        page.keywords = p.inner_text.gsub("\r"," ").gsub("\n"," ").split(" ").join(" ")
        page.save!
      }
    }
  end
end