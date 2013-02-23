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

    BW::Media.play(@tape.url) do |media_player|
      media_player.view.frame = [[10, 100], [100, 100]]
      self.view.addSubview media_player.view
    end
  end
end

