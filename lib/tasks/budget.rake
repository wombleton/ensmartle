namespace :budget do
  desc "parse already downloaded written questions"
  task :d => :environment do
    GenerateDocuments.new.download
  end

  desc "download source pdfs"
  task :dpdf => :environment do
    GenerateDocuments.new.download_pdfs
  end

  desc "convert downloaded pdfs to html"
  task :cpdf => :environment do
    GenerateDocuments.new.convert_pdfs
  end

  desc "populate pages with words from xml"
  task :pxml => :environment do
    GenerateDocuments.new.parse_xml
  end

end
