class AppDelegate
  attr_reader :tapes_controller
  attr_accessor :tapes

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @tapes_controller = TapesController.alloc.initWithNibName(nil, bundle:nil)
    @nav_controller = UINavigationController.alloc.initWithRootViewController(tapes_controller)
    @window.rootViewController = @nav_controller
    @tapes = []
    load_tapes unless RUBYMOTION_ENV == 'test'
    @window.makeKeyAndVisible
    true
  end

  def observedTapes
    self.mutableArrayValueForKey :tapes
  end

  def load_tapes
  	@fetcher = TapeFetcher.new
    if App::Persistence['tapes'] == nil
      Dispatch::Queue.concurrent.async do
        fetch_tapes
      end
    else
    	post_as_data = App::Persistence['tapes']
    	self.tapes = NSKeyedUnarchiver.unarchiveObjectWithData(post_as_data)
    end
  end

   def fetch_tapes
      action = lambda do
      runLoop = NSRunLoop.currentRunLoop
      @fetcher.fetch_tapes do |tape|
        Dispatch::Queue.main.sync do
          observedTapes << tape
          puts 'tape added'
          sleep 1
        end
      end
      runLoop.run
    	post_as_data = NSKeyedArchiver.archivedDataWithRootObject(tapes)
    	App::Persistence['tapes'] = post_as_data
    end

    thread = NSThread.alloc.initWithTarget action, selector:"call", object:nil
    thread.start
  end

end
