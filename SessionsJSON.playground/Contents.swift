//: Playground - noun: a place where people can play

import Cocoa

guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: "/Users/gth/src/IDS/sessions.json")) else {
  fatalError()
}

do {
  let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
  print("\(decoded)")
} catch {
  print("\(error)")
}
