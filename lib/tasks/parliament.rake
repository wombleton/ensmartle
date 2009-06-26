namespace :parl do
  desc "parse already downloaded written questions"
  task :pwq => :environment do
    PersistedFile.load_written_questions
  end

  desc "download written questions from parliament.nz"
  task :dwq => :environment do
    require File.dirname(__FILE__) + '/../written_question_downloader.rb'
    WrittenQuestionDownloader.new.download
  end
end
