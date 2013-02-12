class TapeFetcher

  def initialize
    @host="www.aaspeakers.org"
    @url="http://#{@host}/AA_Speaker_Tapes"
    @debug=true
	end

  def fetch_tapes
    convert_html_to_tapes(fetch_html)
  end

  # fetch the html from the built-in url (not configurable from the outside)
	def fetch_html
    fetch_from_url @url
  end

  def fetch_from_url url
    log "fetching from: #{url}"
    error_ptr = Pointer.new(:object)
    page = NSString.stringWithContentsOfURL(NSURL.URLWithString(url), 
      encoding: NSUTF8StringEncoding, 
      error:error_ptr)
    if error_ptr[0] != nil 
      NSLog("error reading from url: #{url}, error: #{error_ptr[0].description}")
    end
    page
  end

  def convert_html_to_tapes html 
    # puts "convert_html_to_tapes" 
    doc = Wakizashi::HTML(replaceHtmlEntities html)
    rows = doc.xpath("//div[@class='view-content view-content-Speaker-Tapes']//tr")
    # puts "rows size: #{rows.size}"
    @tapes = []
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
        details_hash = fetch_tape_details details_uri
        tape.url = details_hash['url']
      end
      @tapes << tape
    end
    @tapes
  end

  def fetch_tape_details uri
    url = "http://#{@host}#{uri}"
    page = fetch_from_url url
    doc = Wakizashi::HTML(replaceHtmlEntities page)
    download_link = doc.xpath("//a[text()='Download This Speaker Tape']").first
    log "dl=#{download_link['href']}"
    { 'url' => download_link['href'] }
  end

  def replaceHtmlEntities htmlCode
    temp = NSMutableString.stringWithString(htmlCode)
    temp.replaceOccurrencesOfString("&amp;", withString:"&", options:NSLiteralSearch, range:[0, temp.length])
    temp.replaceOccurrencesOfString("&nbsp;", withString:" ", options:NSLiteralSearch, range:[0, temp.length])
    temp
  end

  def log string
    puts string if @debug
  end

end
