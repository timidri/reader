describe "Application 'reader'" do
  before do
    @app = UIApplication.sharedApplication
  end

  it "has one controller" do
    controller = @app.keyWindow.rootViewController
    controller.is_a?(UINavigationController).should == true
  end
end
