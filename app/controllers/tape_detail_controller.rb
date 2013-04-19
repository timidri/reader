class TapeDetailController < UIViewController
  attr_accessor :tape

  def viewDidLoad
    #@label.text = @tape.name
    #@label.sizeToFit
    #@label.center = [self.view.frame.size.width / 2,
      #self.view.frame.size.height / 4]

    @audioPlayer = AudioPlayer.alloc.init
    audioPlayerView = AudioPlayerView.alloc.initWithFrame(self.view.bounds)

    audioPlayerView.delegate = self

    audioPlayerView.audioPlayer = @audioPlayer
    self.view.addSubview audioPlayerView

    #@play_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    #@play_button.setTitle("Play", forState:UIControlStateNormal)
    #@play_button.sizeToFit
    #@play_button.center = [self.view.frame.size.width / 2,
                          #self.view.frame.size.height / 2]
    #@play_button.autoresizingMask = UIViewAutoresizingFlexibleTopMargin
    #@play_button.addTarget(self,
      #action:"play",
      #forControlEvents:UIControlEventTouchUpInside)
    #self.view.addSubview(@play_button)
  end

  def audioPlayerViewPlayFromHTTPSelected audioPlayerView
    url = NSURL.URLWithString(tape.url)
    @audioPlayer.setDataSource(@audioPlayer.dataSourceFromURL(url), withQueueItemId:url)
  end
end

