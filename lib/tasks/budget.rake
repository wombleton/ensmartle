namespace :budget do
  desc "parse already downloaded written questions"
  task :d => :environment do
    GenerateDocuments.new.download
  end
end
