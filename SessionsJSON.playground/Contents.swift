//: Playground - noun: a place where people can play

import Foundation

#if os(Linux)
  typealias RegexType = RegularExpression
  let fileUrl = URL(fileURLWithPath: "sessions.json")
#else
  typealias RegexType = NSRegularExpression
  let fileUrl = Bundle.main.url(forResource: "sessions", withExtension: "json")!
#endif

guard let jsonData = try? Data(contentsOf: fileUrl) else {
  fatalError()
}

guard let sessions = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String:String]] else {
  fatalError()
}

guard let swiftRegex = try? RegexType(pattern: "swift", options: [.caseInsensitive]) else {
  fatalError()
}

for session in sessions {
  if let speaker = session["speaker"], let title = session["title"] {
    if swiftRegex.numberOfMatches(in: title, options: [], range: NSMakeRange(0, title.utf8.count)) > 0 {
      print("\(speaker): \(title)")
    }
  }
}
