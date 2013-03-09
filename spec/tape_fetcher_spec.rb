describe "TapeFetcher" do
  before do
    @fetcher = TapeFetcher.new
    @tapes = [ 
      Tape.new(
        speaker:  "Don C.", 
        city:     "Colorado Springs",
        venue:    "XXXIII Gopher State Roundup",
        date:     "May 27, 2006",
        downloads:"27,046",
        url:      "http://media.aaspeakers.org/download.php?file_id=b321bb67e69bd44f1c8a00e994239988&save=Don%20C.%20from%20Colorado%20Springs%2C%20CO%20-%20XXXIII%20Gopher%20State%20Roundup%20in%20Bloomington%2C%20MN%20on%20%2805-27-2006%29.mp3", 
      ),
      Tape.new(
        speaker:  "Fr. Vaughn Q.", 
        city:     "",
        venue:    "Part 1",
        date:     "January 1, 2000",
        downloads:"13,223",
      ),
      Tape.new(
        speaker:  "June G.", 
        city:     "Los Angeles, CA",
        venue:    "2nd Annual Young at Heart Roundup",
        date:     "May 2, 2003",
        downloads:"15,442",
      ),
    ]

  end

  it "has created a list of tapes from local html" do
  	html_path = File.expand_path("../tape_fetcher_test.html", __FILE__)
  	html = File.read(html_path)
    tapes = []
	  @fetcher.convert_html_to_tapes html do |tape|
      tapes << tape
    end
    @tapes.count.should.equal tapes.count
    @tapes.each_index do |i|
      @tapes[i].speaker.should.equal(tapes[i].speaker)
    end
  end

  it "has parsed detail html page" do
    html_path = File.expand_path("../tape_fetcher_details.html", __FILE__)
    html = File.read(html_path)
    hash = @fetcher.parse_tape_details html
    hash["url"].should.equal @tapes[0].url
  end

end
