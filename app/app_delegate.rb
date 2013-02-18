class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
  	@fetcher = TapeFetcher.new
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = TapesController.alloc.initWithNibName(nil, bundle:nil)
    @tapes = load_tapes
   	@window.rootViewController.tapes = @tapes
    @window.makeKeyAndVisible
    true
  end

  def load_tapes
    if App::Persistence['tapes'] == nil
    	tapes = @fetcher.fetch_tapes
    	puts "saving #{tapes.count} tapes"
    	post_as_data = NSKeyedArchiver.archivedDataWithRootObject(tapes)
    	App::Persistence['tapes'] = post_as_data
    else
    	puts "loading tapes..."
    	post_as_data = App::Persistence['tapes']
    	tapes = NSKeyedUnarchiver.unarchiveObjectWithData(post_as_data)
    	puts "#{tapes.count} loaded."
    end
    tapes
   end
end
