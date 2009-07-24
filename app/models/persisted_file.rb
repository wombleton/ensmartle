class PersistedFile < ActiveRecord::Base
  
  class << self
    def git_push msg="download on #{Date.today.to_s}"
      Dir.chdir storage_path
      puts `git add .`
      puts `git status`
      puts `git commit -m '#{msg}'`
      puts `git push`
    end

    def storage_path
      File.join(RAILS_ROOT, 'nz-hansard')
    end

    def parse_all
      PersistedFile.find(:all).each{|f| f.parse }
    end
  end

  def parse
    open(self.file_path, 'r'){|f| @content = f.read}
    question = WrittenQuestionParser.new.parse(@content)

    if question.save
      puts "Question with id #{question.id} saved!"
    else
      puts "Didn't save due to: #{question.errors.inspect}"
    end
  end

  def exists?
    File.exists? self.file_path
  end

  def file_path
    date_path = self.question_date.strftime('%Y/%m/%d')
    name = self.parliament_url.split('/').last
    File.join(PersistedFile.storage_path, date_path, status, name)
  end
end
