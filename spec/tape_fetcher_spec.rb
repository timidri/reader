describe "TapeFetcher" do
  before do
    @fetcher = TapeFetcher.new
  end

  it "has read the html successfully" do
  	@fetcher.fetch_html
    @fetcher.html.should.not.equal nil
  end

  it "has created a list of tapes" do
  	tape1 = Tape.new 
  	tape1.name = "Roy B."
  	tape_list = [tape1]
  	html_path = File.expand_path("../tape_fetcher_test.html", __FILE__)
  	# puts "html_path: #{html_path}"
  	html = File.read(html_path)
  	html_data = html.dataUsingEncoding(NSUTF8StringEncoding)
	tapes = @fetcher.convert_html_to_tapes html_data 
	tapes.should.equal tape_list
  end
end
