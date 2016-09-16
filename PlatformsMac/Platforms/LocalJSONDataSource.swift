//
//  LocalJSONDataSource.swift
//  Platforms
//
//  Created by Greg Heo on 2016-09-16.
//  Copyright © 2016 Greg Heo. All rights reserved.
//

import Foundation

public class LocalJSONDataSource {
  private(set) public var sessions: [[String: String]] = []

  public init() {
#if os(Linux)
    typealias RegexType = RegularExpression
    let fileUrl = URL(fileURLWithPath: "sessions.json")
#else
  typealias RegexType = NSRegularExpression
  guard let fileUrl = Bundle.main.url(forResource: "sessions", withExtension: "json") else {
    fatalError("Could not get file URL from the bundle!")
  }
#endif
    
    guard let jsonData = try? Data(contentsOf: fileUrl) else {
      fatalError()
    }
    
    guard let swiftRegex = try? RegexType(pattern: "(swift|ios)", options: [.caseInsensitive]) else {
      fatalError()
    }

    do {
      if let sessions = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String:String]] {
        for session in sessions {
          if let title = session["title"] {
            if swiftRegex.numberOfMatches(in: title, options: [], range: NSMakeRange(0, title.utf8.count)) > 0 {
              self.sessions.append(session)
            }
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
