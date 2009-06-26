namespace :budget do
  desc "parse already downloaded written questions"
  task :d => :environment do
    GenerateDocuments.new.download
  end

  desc "download source pdfs"
  task :dpdf => :environment do
    GenerateDocuments.new.download_pdfs
  end

end
