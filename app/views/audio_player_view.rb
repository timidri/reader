class AudioPlayerView < UIView
  attr_accessor :delegate, :audioPlayer

  def initWithFrame frame, withDelegate: delegate
    super

    @tape = delegate.tape
    self.backgroundColor = UIColor.lightGrayColor

    @label = UILabel.new
    @label.text = @tape.name
    @label.textColor = UIColor.whiteColor
    @label.font = UIFont.boldSystemFontOfSize(25)
    @label.lineBreakMode = NSLineBreakByWordWrapping
    @label.numberOfLines = 0
    @label.backgroundColor = UIColor.blackColor
    @label.textAlignment = NSTextAlignmentCenter
    @label.preferredMaxLayoutWidth = 200

    @sublabel = UILabel.new
    @sublabel.text = @tape.venue
    @sublabel.textColor = UIColor.whiteColor
    @sublabel.font = UIFont.boldSystemFontOfSize(20)
    @sublabel.lineBreakMode = NSLineBreakByWordWrapping
    @sublabel.numberOfLines = 0
    @sublabel.backgroundColor = UIColor.blackColor
    @sublabel.textAlignment = NSTextAlignmentCenter
    @sublabel.preferredMaxLayoutWidth = 200

    #@slider = UISlider.alloc.initWithFrame(CGRectMake(20, 290, 280, 20))
    #@slider.continuous = true
    #@slider.addTarget(self, action: 'sliderChanged', forControlEvents: UIControlEventValueChanged)

    @toolbar = UIToolbar.alloc.init
    @toolbar.tintColor = UIColor.blackColor
    @toolbar.frame = self.frame

    @playButton = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemPlay, target: self, action: "playButtonPressed")

    @toolbar = UIView.new
    @toolbar.layer.borderColor = UIColor.blackColor
    @toolbar.layer.borderWidth = 3.0
    @bgLayer = gradient
    @toolbar.layer.insertSublayer(@bgLayer, atIndex:0)

    @volumeView = MPVolumeView.alloc.initWithFrame self.bounds

    Motion::Layout.new do |layout|
      layout.view self
      layout.subviews "label" => @label, "sublabel" => @sublabel, "toolbar" => @toolbar
      layout.metrics "top" => 40
      layout.vertical "|-top-[label]-[sublabel]-[toolbar(66)]|"
      layout.horizontal "|[toolbar]|"
    end

    self.setupTimer
    self.updateControls
    self
  end

  def layoutSubviews
    super
    # @toolbar frame is set by autolayout
    @bgLayer.frame = @toolbar.bounds
  end

  def gradient
    colorOne = UIColor.colorWithRed(80/225.0, green: 80/225.0, blue: 80/225.0, alpha: 1.0)
    colorTwo = UIColor.colorWithRed(24/225.0, green: 25/225.0, blue: 25/225.0, alpha: 1.0)
    colors = [colorOne.CGColor, colorTwo.CGColor]
    locations = [0.0, 1.0]
    headerLayer = CAGradientLayer.layer
    headerLayer.colors = colors
    headerLayer.locations = locations
    headerLayer
  end

  def sliderChanged
    return if (!audioPlayer)
    NSLog("Slider Changed: %f", @slider.value)

    audioPlayer.seekToTime(@slider.value)
  end

  def setupTimer
    timer = NSTimer.timerWithTimeInterval(0.25, target: self, selector: 'tick', userInfo: nil, repeats: true)
    NSRunLoop.currentRunLoop.addTimer('timer', forMode: NSRunLoopCommonModes)
  end

  def tick
    if (!audioPlayer || audioPlayer.duration == 0)
      slider.value = 0
      return
    end

    @slider.minimumValue = 0
    @slider.maximumValue = audioPlayer.duration

    @slider.value = audioPlayer.progress
  end

  #def playFromHTTPButtonTouched
    #self.delegate.audioPlayerViewPlayFromHTTPSelected(self)
  #end

  def playFromLocalFileButtonTouched
    self.delegate.audioPlayerViewPlayFromLocalFileSelected(self)
  end

  def playButtonPressed
    if (!audioPlayer)
      return
    end

    if (audioPlayer.state == AudioPlayerStatePaused)
      audioPlayer.resume
    else
      audioPlayer.pause
    end
  end

  def updateControls
    if (@audioPlayer == nil)
      @playButton.setTitle("Play", forState:UIControlStateNormal)
    elsif (@audioPlayer.state == AudioPlayerStatePaused)
      @playButton.setTitle("Resume", forState:UIControlStateNormal)
    elsif (@audioPlayer.state == AudioPlayerStatePlaying)
      @playButton.setTitle("Pause", forState:UIControlStateNormal)
    else
      @playButton.setTitle("Play", forState:UIControlStateNormal)
    end
  end

  def setAudioPlayer value
    if (audioPlayer)
      audioPlayer.delegate = nil
    end
    audioPlayer = value
    audioPlayer.delegate = self

    self.updateControls
  end

  def audioPlayer(audioPlayer, stateChanged: state)
    self.updateControls
  end

  def audioPlayer(audioPlayer, didEncounterError: errorCode)
    self.updateControls
  end

  def audioPlayer(audioPlayer, didStartPlayingQueueItemId: queueItemId)
    self.updateControls
  end

  def audioPlayer(audioPlayer, didFinishBufferingSourceWithQueueItemId: queueItemId)
    self.updateControls
  end

  def audioPlayer(audioPlayer, didFinishPlayingQueueItemId: queueItemId, withReason: stopReason, andProgress: progress, andDuration: duration)
	  self.updateControls
  end
end
