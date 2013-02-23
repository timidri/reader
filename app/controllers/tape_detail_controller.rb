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
  attr_accessor :label_text

  layout :root do
    @label = subview(UILabel, :label)
  end

  def layoutDidLoad
    @label.text = @label_text
    @label.sizeToFit
    @label.center = [self.view.frame.size.width / 2,
      self.view.frame.size.height / 2]
  end
end

