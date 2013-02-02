describe "Tapes Controller" do
  before do
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = TapesController.alloc.initWithNibName(nil, bundle:nil)
    @window.rootViewController.tapes = []
    5.times do |n|
      tape = Tape.new(name: "Tape #{n}", url: "http://www.foo.bar/tape-#{n}") 
      @window.rootViewController.tapes << tape
    end
    @window.makeKeyAndVisible
  end
  
  tests TapesController

  it "should have title 'Tapes'" do
     @window.rootViewController.title.should == "Tapes"
  end

  it "should have one UITableView" do
    views(UITableView).count.should == 1
  end

  it "has one cell for every tape" do
    views(UITableViewCell).count.should == 5
    view('Tape 1').should.not == nil
  end
end
