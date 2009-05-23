module ElectionHelper
  def link_tweeple(text)
    text.gsub(/@([a-zA-Z0-9_-]+)/, '@<a href="http://twitter.com/\1">\1</a>')
  end
end
