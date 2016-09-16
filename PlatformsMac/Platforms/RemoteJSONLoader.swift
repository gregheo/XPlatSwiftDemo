//
//  RemoteJSONLoader.swift
//  Platforms
//
//  Created by Greg Heo on 2016-09-16.
//  Copyright © 2016 Greg Heo. All rights reserved.
//

import Foundation

class RemoteJSONLoader: JSONLoader {
  public func getJSONData() -> Data {
    do {
      let data = try Data(contentsOf: URL(string: "http://localhost:8090/sessions")!)
      return data
    } catch {
      return Data()
    }
  }
}
