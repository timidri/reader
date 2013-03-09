class AppDelegate
  attr_reader :tapes_controller

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @tapes_controller = TapesController.alloc.initWithNibName(nil, bundle:nil)
    @nav_controller = UINavigationController.alloc.initWithRootViewController(tapes_controller)
    @window.rootViewController = @nav_controller 
    load_tapes unless RUBYMOTION_ENV == 'test'
    @window.makeKeyAndVisible
    true
  end

  def observedTapes
    # puts "observedTapes called, returning: #{self.mutableArrayValueForKey :tapes}"
    self.mutableArrayValueForKey :tapes
  end

  def load_tapes
  	@fetcher = TapeFetcher.new
    if App::Persistence['tapes'] == nil
      Dispatch::Queue.concurrent.async do
        fetch_tapes
      end
      puts "observerdTapes.count = #{observedTapes.count}"
    	puts "saving #{tapes.count} tapes"
    	post_as_data = NSKeyedArchiver.archivedDataWithRootObject(tapes)
    	App::Persistence['tapes'] = post_as_data
    else
    	puts "loading tapes..."
    	post_as_data = App::Persistence['tapes']
    	@tapes_controller.tapes = NSKeyedUnarchiver.unarchiveObjectWithData(post_as_data)
    	puts "#{@tapes_controller.tapes.count} loaded."
    end
  end

   def fetch_tapes
      action = lambda do
      runLoop = NSRunLoop.currentRunLoop
      @fetcher.fetch_tapes do |tape|
        Dispatch::Queue.main.sync do
          puts "adding tape: #{tape}"
          observedTapes << tape
          sleep 1
        end
      end
      
      runLoop.run
    end

    thread = NSThread.alloc.initWithTarget action, selector:"call", object:nil
    thread.start
  end

end
