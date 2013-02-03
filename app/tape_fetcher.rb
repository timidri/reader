class TapeFetcher
	attr_accessor :html

	def initialize
		@url="http://www.aaspeakers.org/AA_Speaker_Tapes"
	end

  def fetch_tapes
    convert_html_to_tapes(fetch_html)
  end
  
  # fetch the html from the built-in url (not configurable from the outside)
	def fetch_html 
    error_ptr = Pointer.new(:object)
		html = NSString.stringWithContentsOfURL(NSURL.URLWithString(@url), 
			encoding: NSUTF8StringEncoding, 
			error:error_ptr)
		if error_ptr[0] != nil 
			NSLog("error reading from url: #{@url}, error: #{error_ptr[0].description}")
		end
    html
  end

  def convert_html_to_tapes html 
     	# puts "convert_html_to_tapes" 
      doc = Wakizashi::HTML(replaceHtmlEntities html)
      rows = doc.xpath("//div[@class='view-content view-content-Speaker-Tapes']//tr")
      # puts "rows size: #{rows.size}"
      @tapes = []
      rows.each do |row| 
        headers = row.elementsForName("th")
        if headers != nil # skip table headers row
          next
        end
        tape = Tape.new
        # puts "row: #{row.to_html}"
        cells = row.elementsForName("td")
        # puts "cells size: #{cells.size}"
        cells.each do |cell|
          # puts "cell to_html: #{cell.to_html}"
          case cell['class']
          when /view-field-node-title/
            name_cells = cell.elementsForName("a")
            if name_cells != nil
              tape.name = name_cells.first
            end
            # puts "found name = #{tape.name}"
          when /city-field/
            tape.city = cell
            # puts "found city = #{tape.city}"
          when /convention-field/
            tape.convention = cell
            # puts "found convention = #{tape.convention}"
          when /date-field/
            date_cells = cell.elementsForName("span")
            if date_cells != nil
              tape.date = date_cells.first
            end
            # puts "found date = #{tape.date}"
          when /downloads-field/
            tape.downloads = cell
            # puts "found downloads = #{tape.downloads}"
          end
        end
        @tapes << tape
      end
      @tapes
  end

  def replaceHtmlEntities htmlCode
    temp = NSMutableString.stringWithString(htmlCode)

    temp.replaceOccurrencesOfString("&amp;", withString:"&", options:NSLiteralSearch, range:[0, temp.length])
    temp.replaceOccurrencesOfString("&nbsp;", withString:" ", options:NSLiteralSearch, range:[0, temp.length])
    temp
  end


end