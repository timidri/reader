class TapesController < UIViewController
  include BubbleWrap::KVO
  attr_accessor :tapes, :table

  def viewDidLoad
    super
    self.title = "Tapes"
    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    @table.autoresizingMask = UIViewAutoresizingFlexibleHeight
    self.view.addSubview(@table)
    @table.dataSource = self
    @table.setDelegate self
  end

  def tapes= newValue
    @tapes = newValue
    observe (App.delegate, :tapes) do |old, new|
      puts "change observed, reloading tableView"
      puts "tapes count = #{@tapes.count}"
      @table.insertRowsAtIndexPaths([NSIndexPath.indexPathForRow(@tapes.count-1, inSection:0)], 
        withRowAnimation:false)
    end
    @table.reloadData if @table
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
    #BW::Media.play_modal(@tapes[indexPath.row].url)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    tape = @tapes[indexPath.row]

    controller = TapeDetailController.alloc.init    
    controller.title = tape.name
    controller.tape = tape

    self.navigationController.pushViewController(controller, animated: true)
  end

end
