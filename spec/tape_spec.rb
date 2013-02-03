describe "Tape" do
  before do
    @tape = Tape.new(speaker: "Speaker", city: "City")
  end

  it "should concat speaker and city" do
    @tape.name.should == "Speaker from City"
  end

  it "should return speaker if city is nil" do
  	@tape.city = nil
    @tape.name.should == "Speaker"
  end

  it "should return speaker if city is empty" do
  	@tape.city = ""
    @tape.name.should == "Speaker"
  end
end
