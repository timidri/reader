class TapeDetailController < UIViewController
  attr_accessor :tape

  def viewDidLoad
    @label = UILabel.new
    @label.text = @tape.name
    @label.textColor = UIColor.whiteColor
    @label.font = UIFont.boldSystemFontOfSize(25)
    @label.lineBreakMode = NSLineBreakByWordWrapping
    @label.numberOfLines = 0
    @label.backgroundColor = UIColor.blackColor
    @label.textAlignment = NSTextAlignmentCenter
    @label.preferredMaxLayoutWidth = 200

    @audioPlayer = AudioPlayer.alloc.init
    url = NSURL.URLWithString(tape.url)
    @audioPlayer.setDataSource(@audioPlayer.dataSourceFromURL(url), withQueueItemId:url)

    @audioPlayerView = AudioPlayerView.alloc.initWithFrame(self.view.bounds)
    @audioPlayerView.delegate = self
    @audioPlayerView.audioPlayer = @audioPlayer

    Motion::Layout.new do |layout|
      layout.view view
      layout.subviews "label" => @label, "player" => @audioPlayerView
      layout.metrics "top" => 40
      layout.vertical "|-top-[label]-[player(==66)]|"
      layout.horizontal "|-[label]-|"
      layout.horizontal "|[player]|"
    end
  end
end

