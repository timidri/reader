class AudioPlayerView < UIView
  attr_accessor :delegate, :audioPlayer

  def initWithFrame frame
    super

    if self
      size = CGSizeMake(180, 50)

      @playFromHTTPButton = UIButton.buttonWithType(UIButtonTypeRoundedRect)
      @playFromHTTPButton.frame = CGRectMake((320  - size.width) /2, 60, size.width, size.height)
      @playFromHTTPButton.addTarget(self, action:'playFromHTTPButtonTouched', forControlEvents: UIControlEventTouchUpInside)
      @playFromHTTPButton.setTitle("Play from HTTP", forState: UIControlStateNormal)

      @playFromLocalFileButton = UIButton.buttonWithType(UIButtonTypeRoundedRect)
      @playFromLocalFileButton.frame = CGRectMake((320 - size.width) / 2, 120, size.width, size.height)
      @playFromLocalFileButton.addTarget(self,  action: 'playFromLocalFileButtonTouched', forControlEvents: UIControlEventTouchUpInside)
      @playFromLocalFileButton.setTitle("Play from Local File", forState:UIControlStateNormal)

      @playButton = UIButton.buttonWithType(UIButtonTypeRoundedRect)
      @playButton.frame = CGRectMake((320 - size.width) / 2, 350, size.width, size.height)
      @playButton.addTarget(self, action: 'playButtonPressed', forControlEvents: UIControlEventTouchUpInside)

      @slider = UISlider.alloc.initWithFrame(CGRectMake(20, 290, 280, 20))
      @slider.continuous = true
      @slider.addTarget(self, action: 'sliderChanged', forControlEvents: UIControlEventValueChanged)

      self.addSubview @slider
      self.addSubview @playButton
      self.addSubview @playFromHTTPButton
      #self.addSubview @playFromLocalFileButton

      self.setupTimer
      self.updateControls
    end
    self
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

  def playFromHTTPButtonTouched
    self.delegate.audioPlayerViewPlayFromHTTPSelected(self)
  end

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
