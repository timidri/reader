describe "Tapes Controller" do
  tests TapesController

  before do
    @app = UIApplication.sharedApplication
  end

  it "should have title 'Tapes'" do
    controller.title.should == "Tapes"
  end

  it "should have one UITableView" do
    views(UITableView).count.should == 1
  end
end
