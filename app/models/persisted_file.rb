class PersistedFile < ActiveRecord::Base
  
  class << self
    def git_push msg="download on #{Date.today.to_s}"
      Dir.chdir storage_path
      puts `git add .`
      puts `git status`
      puts `git commit -m '#{msg}'`
      puts `git push`
    end

    def git_pull
      Dir.chdir storage_path
      puts `git pull origin master`
    end

    def storage_path
      File.join(RAILS_ROOT, 'nz-hansard')
    end

    def parse_all
      PersistedFile.find(:all, :conditions => {:persisted => nil}).each{|f| f.parse }
    end
  end

  def parse
    File.open(self.file_path, 'r'){|f| @content = f.read}
    question = WrittenQuestionParser.new.parse(@content)

    existing = WrittenQuestion.find(:first, :conditions => {:question_year => question.question_year, :question_number => question.question_number})
    if existing.nil?
      if question.save
        self.update_attribute(:persisted, true)
        puts "Question with id #{question.id} saved!"
      else
        puts "Didn't save due to: #{question.errors.inspect}"
      end
    else
      existing.update_attributes(:answer => question.answer, :respondent_name => question.respondent_name, :respondent_url => question.respondent_url, :status => question.status)
      self.update_attribute(:persisted, true)
      puts "Question with id #{existing.id} saved!"
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

  def url
    matches = /.+(QWA_\d{5}_\d{4}).+/.match(self.parliament_url)
    if matches.nil?
      self.parliament_url
    else
      "http://www.parliament.nz/en-NZ/?document=#{matches[1]}"
    end
  end
end
