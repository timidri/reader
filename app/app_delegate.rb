class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
  	@fetcher = TapeFetcher.new
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = TapesController.alloc.initWithNibName(nil, bundle:nil)
    @window.rootViewController.tapes = @fetcher.fetch_tapes
    @window.makeKeyAndVisible
    true
  end
end
