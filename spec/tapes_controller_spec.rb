describe "Tapes Controller" do
  before do
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = TapesController.alloc.initWithNibName(nil, bundle:nil)
    @window.rootViewController.tapes = ['tape 1', 'tape 2', 'tape 3']
    @window.makeKeyAndVisible
  end
  
  tests TapesController

  #before do
    #@app = UIApplication.sharedApplication
  #end

  it "should have title 'Tapes'" do
     @window.rootViewController.title.should == "Tapes"
  end

  it "should have one UITableView" do
    views(UITableView).count.should == 1
  end

  it "has one cell for every tape" do
    views(UITableViewCell).count.should == 3
    view('tape 1').should.not == nil
  end
end
