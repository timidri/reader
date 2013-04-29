class TapeDetailController < UIViewController
  attr_accessor :tape

  def viewDidLoad
    @audioPlayer = AudioPlayer.alloc.init
    url = NSURL.URLWithString(tape.url)
    @audioPlayer.setDataSource(@audioPlayer.dataSourceFromURL(url), withQueueItemId:url)

    @audioPlayerView = AudioPlayerView.alloc.initWithFrame(self.view.bounds, withDelegate: self)
    @audioPlayerView.audioPlayer = @audioPlayer
    self.view = @audioPlayerView
  end
end

