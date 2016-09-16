//
//  LocalJSONLoader.swift
//  Platforms
//
//  Created by Greg Heo on 2016-09-16.
//  Copyright © 2016 Greg Heo. All rights reserved.
//

import Foundation

public class LocalJSONLoader: JSONLoader {
  public func getJSONData() -> Data {
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
    
    return jsonData
  }
}
