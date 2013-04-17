Teacup::Stylesheet.new :tape_detail do
  style :root,
    backgroundColor: UIColor.whiteColor

  style :label,
    text: 'Hi!',
    size: [27, 21],
    origin: [0, 0]
end

class TapeDetailController < UIViewController
  stylesheet :tape_detail
  attr_accessor :tape

  layout :root do
    @label = subview(UILabel, :label)
  end

  def layoutDidLoad
    @label.text = @tape.name
    @label.sizeToFit
    @label.center = [self.view.frame.size.width / 2,
      self.view.frame.size.height / 2]
    puts @tape.url
    url = NSURL.URLWithString(@tape.url)
    error_ptr = Pointer.new(:object)
    audioPlayer = AVAudioPlayer.alloc.initWithContentsOfURL(url, error: error_ptr)
    if(audioPlayer == nil)
      error = error_ptr[0]
      $stderr.puts "Error playing audio: #{error}"
    else
      audioPlayer.numberOfLoops = -1
      audioPlayer.play
    end
  end
end

