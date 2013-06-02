class TapeFetcher

  attr_accessor :delegate

  def initialize
    @host="www.aaspeakers.org"
    @url="http://#{@host}/AA_Speaker_Tapes"
    @debug=true
	end

  def fetch_tapes (url=@url, &block)
    log "fetching from url: #{url}"
    BW::HTTP.get(@url) do |response|
      convert_html_to_tapes (response.body.to_str, &block)
    end
  end

  def convert_html_to_tapes (html, &block)
    # puts "convert_html_to_tapes"
    doc = Wakizashi::HTML(replaceHtmlEntities html)
    rows = doc.xpath("//div[@class='view-content view-content-Speaker-Tapes']//tr")
    # puts "rows size: #{rows.size}"
    rows.each do |row|
      headers = row.elementsForName("th")
      next if headers != nil # skip table headers row
      tape = Tape.new
      details_uri = nil
      # puts "row: #{row.to_html}"
      cells = row.elementsForName("td")
      # puts "cells size: #{cells.size}"
      cells.each do |cell|
        # puts "cell to_html: #{cell.to_html}"
        case cell['class']
        when /view-field-node-title/
          name_cells = cell.elementsForName("a")
          if name_cells != nil
            tape.speaker = name_cells.first.stringValue
            details_uri = name_cells.first['href']
          end
          # puts "found name = #{tape.name}"
        when /city-field/
          tape.city = cell.stringValue
          # puts "found city = #{tape.city}"
        when /convention-field/
          tape.venue = cell.stringValue
          # puts "found convention = #{tape.convention}"
        when /date-field/
          date_cells = cell.elementsForName("span")
          if date_cells != nil
            tape.date = date_cells.first.stringValue
          end
          # puts "found date = #{tape.date}"
        when /downloads-field/
          tape.downloads = cell.stringValue
          # puts "found downloads = #{tape.downloads}"
        end
      end
      if details_uri
        if RUBYMOTION_ENV == 'test'
          tape.url = ''
        else
          fetch_tape_details "http://#{@host}#{details_uri}", tape
        end
      end
      block.call tape
    end
  end

  def fetch_tape_details url, tape
    log "fetching details from: #{url}"
    BW::HTTP.get(url) do |response|
      page = response.body.to_str
      hash = parse_tape_details page
      puts hash[:url]
      tape.url = hash[:url]
    end
  end

  def parse_tape_details html
    doc = Wakizashi::HTML(replaceHtmlEntities html)
    download_link = doc.xpath("//a[text()='Download This Speaker Tape']").first
    puts download_link['href']
    hash = { :url => download_link['href'] }
    hash
  end

  def replaceHtmlEntities htmlCode
    temp = NSMutableString.stringWithString(htmlCode)
    temp.replaceOccurrencesOfString("&amp;", withString:"&",
      options:NSLiteralSearch, range:[0, temp.length])
    temp.replaceOccurrencesOfString("&nbsp;", withString:" ",
      options:NSLiteralSearch, range:[0, temp.length])
    temp
  end

  def log string
    puts string if @debug
  end

end
