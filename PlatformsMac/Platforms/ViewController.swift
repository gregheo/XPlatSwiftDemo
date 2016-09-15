//
//  ViewController.swift
//  Platforms
//
//  Created by Greg Heo on 2016-09-15.
//  Copyright © 2016 Greg Heo. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  @IBOutlet weak var tableView: NSTableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
  }

}

extension ViewController: NSTableViewDataSource {
  func numberOfRows(in tableView: NSTableView) -> Int {
    return 10
  }
}

extension ViewController: NSTableViewDelegate {
  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    guard let tableColumn = tableColumn else {
      return nil
    }
    
    guard let cellView = tableView.make(withIdentifier: tableColumn.identifier , owner: nil) as? NSTableCellView else {
      return nil
    }
    
    if tableColumn == tableView.tableColumns[0] {
      cellView.textField?.stringValue = "Column zero!"
    } else if tableColumn == tableView.tableColumns[1] {
      cellView.textField?.stringValue = "Column one!"
    } else if tableColumn == tableView.tableColumns[2] {
      cellView.textField?.stringValue = "Column two!"
    }
    
    return cellView
  }
}
