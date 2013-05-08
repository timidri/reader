class TapesController < UIViewController
  include BubbleWrap::KVO
  attr_accessor :table

  def viewDidLoad
    super
    self.title = "Tapes"
    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    @table.autoresizingMask = UIViewAutoresizingFlexibleHeight
    self.view.addSubview(@table)
    @table.dataSource = self
    @table.setDelegate self
    observe (App.delegate, :tapes) do |old, new|
      @table.reloadData if @table
    end
  end

  def viewDidUnload
    App.delegate.remove_observer(self)
  end

  def tapes
    App.delegate.tapes
  end

  def tableView(tableView, numberOfRowsInSection: section)
    tapes ? tapes.count : 0
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: @reuseIdentifier)
    cell.textLabel.text = tapes[indexPath.row].name
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    tape = tapes[indexPath.row]

    controller = TapeDetailController.alloc.init
    controller.title = ""
    controller.tape = tape

    self.navigationController.pushViewController(controller, animated: true)
  end

end
