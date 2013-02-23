#describe "TapeFetcher" do
  #before do
    #@fetcher = TapeFetcher.new
    #@url = "http://media.aaspeakers.org/download.php?file_id=b321bb67e69bd44f1c8a00e994239988&save=Don%20C.%20from%20Colorado%20Springs%2C%20CO%20-%20XXXIII%20Gopher%20State%20Roundup%20in%20Bloomington%2C%20MN%20on%20%2805-27-2006%29.mp3"
    #@test_tape = Tape.new(
      #speaker:  "Don C.", 
      #city:     "Colorado Springs",
      #venue:    "XXXIII Gopher State Roundup",
      #date:     "May 27, 2006",
      #downloads:"27,046",
      #url:       @url
    #)
  #end

  #it "has fetched the html successfully" do
    #html = @fetcher.fetch_html
    #html.should.not.equal nil
  #end

  #it "has created a list of tapes from local html" do
    #html_path = File.expand_path("../tape_fetcher_test.html", __FILE__)
    #html = File.read(html_path)
		#tapes = @fetcher.convert_html_to_tapes html 
		#tapes.first.speaker.should.equal @test_tape.speaker
  #end

  #it "has created a list of tapes from fetched html" do
    #html = @fetcher.fetch_html
    #tapes = @fetcher.convert_html_to_tapes html
    #tapes.count.should.equal 20
  #end

  #it "has scraped a detail screen for a given html" do
    #uri = "/Don_C-from-Colorado_Springs_CO-at-the_XXXIII_Gopher_State_Roundup-in-Bloomington_MN-on-05-27-2006"
    #hash = @fetcher.fetch_tape_details uri
    #hash['url'].should == @url
  #end

  #it "has created a list of tapes from local html, including urls" do
    #html_path = File.expand_path("../tape_fetcher_test.html", __FILE__)
    #html = File.read(html_path)
    #tapes = @fetcher.convert_html_to_tapes html 
    #tapes.first.url.should.equal @test_tape.url
  #end


#end
