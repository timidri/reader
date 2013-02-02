class Tape
	attr_accessor :name
end

class TapeFetcher
	attr_accessor :html

	def initialize
		@url="http://www.aaspeakers.org/AA_Speaker_Tapes"
		@html=nil
	end

	def fetch_html 
		error_ptr = Pointer.new(:object)
		@html = NSData.dataWithContentsOfURL(NSURL.URLWithString(@url), 
			encoding: NSUTF8StringEncoding, 
			error:error_ptr)
		if error_ptr[0] != nil 
			NSLog("error reading from url: #{@url}, error: #{error_ptr[0].description}")
		end
		# NSLog("html read from url: {@url}: #{@html.description}")
		# parser = NSXMLParser.alloc.initWithData(data)
  		# parser.setDelegate(self)
  		#  parser.parse
  	end

  	def convert_html_to_tapes html=@html 
     	puts "convert_html_to_tapes: html=#{html}" 
    	parser = NSXMLParser.alloc.initWithData(replaceHtmlEntities html)
    	parser.setDelegate(self)
    	parser.parse
  	end

  	def parser(parser, parseErrorOccurred:errorOccurred)
  		puts "errorOccurred: #{errorOccurred.description}" 
  	end

  	def parserDidStartDocument(parser)
     	puts "parserDidStartDocument" 
	   	@tapes = []
    	@inEntry = false
    	@inContent = false
  	end
	
  	def parserDidEndtDocument(parser)
     	puts "parserDidEndDocument" 
  	end

  	def parser(parser, 
  			didStartElement:elementName, 
  			namespaceURI:namespaceURI, 
  			qualifiedName:qualifiedName, 
  			attributes:attributeDict)
    	puts "end - elname: #{elementName}, qname: #{qualifiedName}" 
    	@currentValue = ""
    	if elementName == "div" && attributeDict["class"] == "view-content view-content-Speaker-Tapes"
    		@inContent = true
    		puts "div seen with attr dict: #{attributeDict}"
    	end
  	end

  	def parser(parser, didEndElement:elementName, namespaceURI:namespaceURI, qualifiedName:qualifiedName)
    	puts "end - elname: #{elementName}, qname: #{qualifiedName}" 
  	end

  def parser(parser, foundCharacters:string)
    @currentValue += string
    puts "currentValue: #{@currentValue}"
  end
  

  def replaceHtmlEntities data

    htmlCode = NSString.alloc.initWithData(data, encoding:NSUTF8StringEncoding)
    temp = NSMutableString.stringWithString(htmlCode)

    temp.replaceOccurrencesOfString("&amp;", withString:"&", options:NSLiteralSearch, range:[0, temp.length])
    temp.replaceOccurrencesOfString("&nbsp;", withString:" ", options:NSLiteralSearch, range:[0, temp.length])
    finalData = temp.dataUsingEncoding(NSUTF8StringEncoding)
    finalData
  end


end