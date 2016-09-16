//
//  JSONDataSource.swift
//  Platforms
//
//  Created by Greg Heo on 2016-09-16.
//  Copyright © 2016 Greg Heo. All rights reserved.
//

import Foundation

public protocol JSONLoader {
  func getJSONData() -> Data
}

public class JSONDataSource {
  private(set) public var sessions: [[String: String]] = []
  
  public init(jsonLoader: JSONLoader) {
    #if os(Linux)
      typealias RegexType = RegularExpression
    #else
      typealias RegexType = NSRegularExpression
    #endif
    
    guard let swiftRegex = try? RegexType(pattern: ".*", options: [.caseInsensitive]) else {
      fatalError()
    }
    
    let jsonData = jsonLoader.getJSONData()

    do {
      if let sessions = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String:String]] {
        for session in sessions {
          guard let title = session["title"] else { continue }
          
          if swiftRegex.numberOfMatches(in: title, options: [], range: NSMakeRange(0, title.utf8.count)) > 0 {
            self.sessions.append(session)
          }
        }
      }
    } catch {
      fatalError()
    }
  }
  
  public var count: Int {
    return sessions.count
  }
}
