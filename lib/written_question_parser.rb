require 'hpricot'

class WrittenQuestionParser
  def parse html
    q = WrittenQuestion.new
    @doc = Hpricot.parse(html)

    date_text = @doc.at("meta[@name='DC.Date']").get_attribute(:content)
    q.date_asked = Date.parse(date_text[0,10])

    title = @doc.at("meta[@name='DC.Title']").get_attribute(:content)
    matches = /^(\d+) \((\d{4})\)\. (.+?) to the (.+)/i.match(title)

    q.question_number = matches[1]
    q.question_year = matches[2]

    q.subject = @doc.at("meta[@name='DC.Subject']").get_attribute(:content)

    q.portfolio_name = matches[4].strip
    q.portfolio_url = portfolio_url q.portfolio_name

    asker_name = matches[3]
    q.asker_name = asker_name
    q.asker_url = substitute(asker_name)

    q_text = @doc.at(".qandaset .question").inner_html.gsub(/[\t\n]/, " ").squeeze(" ")
    q.question = /.+\(\d{1,2} \w{3} \d{4}\):(.+)/.match(q_text)[1].strip


    answer = @doc.at(".qandaset .answer")
    a_text = answer.inner_html
    q.answer = /.+\) replied: (.+)/m.match(a_text)[1].gsub(/\n/, ' ').squeeze(' ').strip

    if /Reply due: \d{1,2} \w{3} \d{4}/.match(q.answer).nil?
      q.status = "reply"
    else
      q.status = "question"
    end

    if q.status == "reply"
      respondent_name = answer.at(".Minister").inner_html.gsub(/[\n\t]/, "").squeeze(" ").strip
      q.respondent_name = respondent_name
      q.respondent_url = substitute(respondent_name)
    end
    q
  end

  def portfolio_url name
    excisions = [
      /(associate_)?minister_for_/,
      /(associate_)?minister_of_/,
      /minister_in_charge_of_/,
      /(associate_)?minister_responsible_for_/,
      /\(.+\)/,
      /includes_responsibility_for.+$/,
      /^_+/,
      /_+$/
    ]

    substitutions = {
      "energy_resources" => "energy",
      "building_construction" => "building_issues",
      "climate_change_issues" => "climate_change",
      "gcsb" => "communications_security_bureau",
      "nz_security_intelligence_service" => "security_intelligence_service",
      "leader_of_house" => "the_house",
      "deputy_leader_of_house" => "the_house",
      "speaker_of_house_of_representatives" => "the_house",
    }

    url = unpunctuate(name).gsub(/\b((the)|(and))\b/, '').gsub(/[ -]/ , "_").downcase
    excisions.each{|e|
      url = url.gsub(e, '').squeeze("_")
    }
    url = substitutions[url] if substitutions.has_key?(url)
    url
  end

  def substitute s
    result = unhonorofic(s)
    substitutions = {
      "luamanuvao_winnie_laban" => "luamanuvao_laban"
    }
    result = substitutions[result] if substitutions.has_key?(result)
    result
  end

  def unhonorofic s
    tokens = %W(hon dr h v sir)
    re = Regexp.new(tokens.map{|key| "\\b#{key}\\b"}.join("|"))

    unpunctuate(s).downcase.gsub(re, '').split(' ').join('_')
  end

  def unpunctuate s
    s.tr("().,:;?!*'’",'') unless s.nil?
  end
end