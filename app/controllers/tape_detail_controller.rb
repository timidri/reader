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

    @sublabel = UILabel.new
    @sublabel.text = @tape.venue
    @sublabel.textColor = UIColor.whiteColor
    @sublabel.font = UIFont.boldSystemFontOfSize(20)
    @sublabel.lineBreakMode = NSLineBreakByWordWrapping
    @sublabel.numberOfLines = 0
    @sublabel.backgroundColor = UIColor.blackColor
    @sublabel.textAlignment = NSTextAlignmentCenter
    @sublabel.preferredMaxLayoutWidth = 200

    @audioPlayer = AudioPlayer.alloc.init
    url = NSURL.URLWithString(tape.url)
    @audioPlayer.setDataSource(@audioPlayer.dataSourceFromURL(url), withQueueItemId:url)

    @audioPlayerView = AudioPlayerView.alloc.initWithFrame(self.view.bounds)
    @audioPlayerView.delegate = self
    @audioPlayerView.audioPlayer = @audioPlayer

    Motion::Layout.new do |layout|
      layout.view view
      layout.subviews "label" => @label, "sublabel" => @sublabel, "player" => @audioPlayerView
      layout.metrics "top" => 40
      layout.vertical "|-top-[label]-[sublabel]-[player(==66)]|"
      #layout.horizontal "|-[label]-|"
      layout.horizontal "|[player]|"
    end
  end
end

