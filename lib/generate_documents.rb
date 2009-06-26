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
      document = Document.new
      document.date = Date.parse(r.at('td[1]').inner_html)
      document.document_type = r.at('td[2]').inner_html
      document.title = r.at('td[3]').inner_html.gsub(/(<em>.+<\/em>)|(<br \/>)/, '')
      document.url = "http://www.treasury.govt.nz" + r.at('td[4] a').attributes['href']
      document.pdf_name = document.url.split("/").last

      document.save!
      puts `convert #{document.url} #{File.join(RAILS_ROOT, "files", File.basename(document.pdf_name, ".pdf") + ".png")}`
      images = Dir.glob(File.join(RAILS_ROOT, "public", "images", "files", File.basename(document.pdf_name, ".pdf") + "*.png"))
      images.each{|image|
        page = Page.new
        page.document = document
        page.image_path = File.join("files", File.basename(image))
        page.page_no = File.basename(image, ".png").split("-").last.to_i
        page.save!
      }
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
end