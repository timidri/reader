describe "TapeFetcher" do
  before do
    @fetcher = TapeFetcher.new
  end

  it "has read the html successfully" do
  	html = @fetcher.fetch_html
    html.should.not.equal nil
  end

  it "has created a list of tapes from local html" do
  	tape1 = Tape.new 
  	tape1.name = "Roy B."
  	tape_list = [tape1]
  	html_path = File.expand_path("../tape_fetcher_test.html", __FILE__)
  	# puts "html_path: #{html_path}"
  	html = File.read(html_path)
  	# html_data = html.dataUsingEncoding(NSUTF8StringEncoding)
	  tapes = @fetcher.convert_html_to_tapes html 
	  tapes.size.should.equal 3
  end

  it "has created a list of tapes from read html" do
    html = @fetcher.fetch_html
    tapes = @fetcher.convert_html_to_tapes html
    tapes.size.should.equal 20
  end
end
