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

  var sessionDataSource = JSONDataSource(jsonLoader: RemoteJSONLoader())
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.reloadData()
  }

}

extension ViewController: NSTableViewDataSource {
  func numberOfRows(in tableView: NSTableView) -> Int {
    return sessionDataSource.count
  }
}

extension ViewController: NSTableViewDelegate {
  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    let session = sessionDataSource.sessions[row]
    
    guard
      let tableColumn = tableColumn,
      let cellView = tableView.make(withIdentifier: tableColumn.identifier , owner: nil) as? NSTableCellView,
      let sessionTitle = session["title"],
      let sessionSpeaker = session["speaker"],
      let sessionTime = session["time"]
    else {
      return nil
    }

    if tableColumn == tableView.tableColumns[0] {
      cellView.textField?.stringValue = sessionTime
    } else if tableColumn == tableView.tableColumns[1] {
      cellView.textField?.stringValue = sessionTitle
    } else if tableColumn == tableView.tableColumns[2] {
      cellView.textField?.stringValue = sessionSpeaker
    }
    
    return cellView
  }
}
