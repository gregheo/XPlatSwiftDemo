//
//  LocalJSONDataSource.swift
//  Platforms
//
//  Created by Greg Heo on 2016-09-16.
//  Copyright © 2016 Greg Heo. All rights reserved.
//

import Cocoa

public class LocalJSONDataSource {
  private(set) public var sessions: [[String: String]] = []

  public init() {
    let fileUrl = Bundle.main.url(forResource: "sessions", withExtension: "json")!
    
    guard let jsonData = try? Data(contentsOf: fileUrl) else {
      fatalError()
    }
    
    do {
      if let sessions = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String:String]] {
        self.sessions = sessions
      }
    } catch {
      fatalError()
    }
  }
  
  public var count: Int {
    return sessions.count
  }
}
