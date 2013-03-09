describe "Tapes Controller" do
  tests TapesController
  
  before do
    controller.tapes = []
 
    5.times do |n|
      tape = Tape.new(speaker: "Speaker #{n}", city: "City #{n}") 
      controller.tapes << tape
    end
    controller.table.reloadData

  end

  it "should have title 'Tapes'" do
    controller.title.should == "Tapes"
  end

  it "should have one UITableView" do
    views(UITableView).count.should == 1
  end

  it "has one cell for every tape" do
    views(UITableViewCell).count.should == 5
  end

  it "sets the name of each cell correctly" do
    view("Speaker 1 from City 1").should != nil
  end

end
