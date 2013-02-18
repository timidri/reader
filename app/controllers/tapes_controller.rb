class TapesController < UIViewController
  include BubbleWrap::KVO
  attr_accessor :tapes

  def viewDidLoad
    super
    self.title = "Tapes"
    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    @table.autoresizingMask = UIViewAutoresizingFlexibleHeight
    self.view.addSubview(@table)
    @table.dataSource = self
    @table.setDelegate self

  end

  def tableView(tableView, numberOfRowsInSection: section)
    @tapes ? @tapes.count : 0
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: @reuseIdentifier)
    
    cell.textLabel.text = @tapes[indexPath.row].name
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
      BW::Media.play_modal(@tapes[indexPath.row].url)
  end

end
