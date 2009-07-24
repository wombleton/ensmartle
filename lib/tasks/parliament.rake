namespace :parliament do
  desc "parse already downloaded written questions"
  task :parse => :environment do
    PersistedFile.parse_all
  end

  desc "download written questions from parliament.nz"
  task :download => :environment do
    require File.dirname(__FILE__) + '/../written_question_downloader.rb'
    WrittenQuestionDownloader.new.download
  end

  task :update => [:download, :parse]
end
