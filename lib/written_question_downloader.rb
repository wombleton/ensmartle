require 'rubygems'
require 'open-uri'
require 'hpricot'

class WrittenQuestionDownloader
  STATUSES = ["Question", "Reply"]

  def download
    PersistedFile.git_pull
    
    finished = false
    page = 0
    questions = questions_in_index(page)

    bad_pages = bad_pages questions
    
    while !questions.empty? and !finished
      finished = download_questions(questions)
      begin
        page = page.next
      end while bad_pages.include?(page)
      questions = questions_in_index(page)
    end

    PersistedFile.git_push
  end

  def bad_pages questions
    latest = get_question_number questions.first
    earliest_query = WrittenQuestion.find(:first, :limit => 1, :conditions => ['status = ?', 'question'], :order => 'question_year, question_number')
    last_persisted = WrittenQuestion.find(:first, :limit => 1, :conditions => ['status = ?', 'question'], :order => 'question_year desc, question_number desc')

    if earliest_query.nil?
      @earliest = 0
      after_year = 0
      after_question = 0
    else
      after_year = earliest_query.question_year
      after_question = earliest_query.question_number
      @earliest = (earliest_query.question_year * 100000) + earliest_query.question_number
    end

    unanswereds = WrittenQuestion.find(:all, :conditions => ['question_year >= ? and question_number >= ? and status = ?', after_year, after_question, 'question'], :order => "question_year desc, question_number desc").map{|q| q.question_number}
    bad_pages = []
    p = 0
    while latest > 0
      range = (latest-19..latest).to_a
      latest = latest - 20
      bad_pages << p if (range & unanswereds).length == 0 and latest.id < last_persisted.id
      p = p.next
    end
    puts bad_pages.inspect
    bad_pages
  end

  def open_index_page page
    url = "http://www.parliament.nz/en-NZ/PB/Business/QWA/Default.htm?p=#{page}&search=384924419"
    puts "opening #{url}"
    Hpricot open(url)
  end

  def questions_in_index page
    doc = open_index_page page
    (doc/'.listing tbody tr')
  end

  def download_questions questions
    finished = false
    questions.each do |question|
      unless finished
        finished = download_question(question)
      end
    end
    finished
  end

  def download_question question
    date = date_question question
    status = get_status question
    question_number = get_question_number question

    q_no = (date.year  * 100000) + question_number

    if q_no > @earliest and STATUSES.include?(status)
      finished = continue_download question, date, status
    end
    if q_no < @earliest
      finished = true
    end
    finished
  end

  def continue_download question, date, status
    name = parliament_name(question, status)
    persisted_file = PersistedFile.find_or_create_by_parliament_name(name)
    if persisted_file.parliament_url.nil?
      persisted_file.question_date = date
      persisted_file.parliament_url = question_url(question)
      persisted_file.status = status
      persisted_file.save!
    end
    download_this_question persisted_file unless persisted_file.downloaded?
    
    false
  end

  def parliament_name question, status
    "#{status}: #{question.at("h4 a").inner_html}"
  end

  def download_this_question persisted_file
    if File.exist?(persisted_file.file_path)
      puts "Using already downloaded version at #{persisted_file.file_path}."
      persisted_file.downloaded = true
      persisted_file.save!
    else
      contents = question_contents(persisted_file.parliament_url)
      unless contents.include? 'Server Error'
        FileUtils.mkdir_p File.dirname(persisted_file.file_path)
        File.open(persisted_file.file_path, 'w') do |file|
          file.write(contents)
          persisted_file.downloaded = true
        end
        persisted_file.save!
      end
    end
  end

  def question_contents url
    contents = nil
    puts "Downloading #{url}"
    open(url) { |io| contents = io.read }
    contents
  end


  def question_url question
    "http://www.parliament.nz#{question.at("h4 a").attributes["href"]}"
  end

  def get_question_number question
    question.at('h4 a').inner_html.to_i
  end

  def get_status question
    question.at('.attrStatus').inner_html
  end

  def date_question question
    content = question.at('.attrPublicationDate').inner_html
    date = Date.parse("#{content[0,6]} 20#{content[7,2]}")
    date
  end

  def fetch person
    begin
      unless @people.include? person
        @people << person
        open(person){|f| @response = f.read }
        doc = Hpricot(@response)
        u = "http://theyworkforyou.co.nz#{(doc/'img.portrait').first.attributes['src']}"
        out = open(File.join(RAILS_ROOT, "public", "images", person.split("/").last + ".jpg"), "wb")
        out.write(open(u).read)
        out.close
      end
    rescue
      puts "couldn't download #{person}"
    end
  end

  def download_images
    @urls = []
    @people = []
    WrittenQuestion.find(:all).each{|q|
      fetch "http://theyworkforyou.co.nz/mps/#{q.asker_url}"
      fetch "http://theyworkforyou.co.nz/mps/#{q.respondent_url}" unless q.respondent_url.nil?
    }

    @urls.each{|u|
    }
  end
end
