require 'fileutils'
require 'nokogiri'
require 'open-uri'
require 'json'

module StatusPreparator
  ## Parsing status
  def self.status(archive = nil)
    begin
      url = case Random.rand(3)
              when 0 then open('http://www.brainyquote.com/quotes/favorites.html')
              when 1 then open('http://www.brainyquote.com/quotes/topics.html')
              else open('http://www.brainyquote.com')
            end
      doc = Nokogiri::HTML(url)
      body = doc.css('.ws-title .bq-slide-q-text a.bq-sl-lnk').text.gsub("\n", '')
      author = doc.css('.ws-title .ws-author').text
      raise Exception if body.length.zero? || author.length.zero?
      add_to_quotes(author, body) if archive
      to_ahcii!("\"#{body}\" (c) #{author}")
    rescue Exception
      archived_status
    end
  end


  private


  def self.add_to_quotes(author, body)
    quotes_json = File.exist?("#{File.dirname(__FILE__)}/quotes.json") ? JSON.parse( File.read("#{File.dirname(__FILE__)}/quotes.json") ) : [{}]
    quotes = Array.new
    quotes_json.each{ |quote| quote.each{ |key, value| quotes << value } }
    unless quotes.any?{ |quote| quote['body'] == body }
      quotes << { "author" => author, "body" => body }
      quotes_to_json = quotes.sort_by{ |quote| quote['author'] }.map{ |quote| { quote: quote } }
      File.open("#{File.dirname(__FILE__)}/quotes.json", 'w+'){ |file| file.write(JSON.pretty_generate(quotes_to_json)) }
    end
  end

  def self.archived_status
    begin
      quotes_json = JSON.parse( File.read("#{File.dirname(__FILE__)}/quotes.json") )
      quotes = Array.new
      quotes_json.each{ |quote| quote.each{ |key, value| quotes << value } }
      lucky_quote = quotes[rand(quotes.size)]
      to_ahcii!("\"#{lucky_quote['body']}\" (c) #{lucky_quote['author']}")
    rescue Exception
      to_ahcii!("\"404 - Status was here. D:\" (с) Sashucii")
    end
  end

  def self.to_ahcii!(text)
    URI.escape text
  end
end