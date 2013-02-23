class AppDelegate
  attr_reader :tapes_controller

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @tapes_controller = TapesController.alloc.initWithNibName(nil, bundle:nil)
    nav_controller = UINavigationController.alloc.initWithRootViewController(tapes_controller)
    @window.rootViewController = nav_controller 
    
    @tapes_controller.tapes = load_tapes unless RUBYMOTION_ENV == 'test'
    
    @window.makeKeyAndVisible
    true
  end

  def load_tapes
  	@fetcher = TapeFetcher.new
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
