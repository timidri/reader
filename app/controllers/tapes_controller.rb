class TapesController < UIViewController
  def viewDidLoad
    super
    self.title = "Tapes"
    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    @table.autoresizingMask = UIViewAutoresizingFlexibleHeight
    self.view.addSubview(@table)
  end
end
