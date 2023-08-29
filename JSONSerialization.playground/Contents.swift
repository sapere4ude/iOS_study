import UIKit
import Foundation

// 공부자료: https://ios-development.tistory.com/1482

let jsonString = """
 {
    "name": "KANT",
    "age": 30,
    "isStudent": false
}
"""

//let jsonData = jsonString.data(using: .utf8)!
//
//// jsonData > Dictionary
//let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
//print(dictionary)
//
//// Dictionary > jsonData
//let newJsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
//print(newJsonData)


struct Singer: Codable {
    let name: String
    let age: Int
    let isGroup: Bool
}

let singer = Singer(name: "aimyon", age: 28, isGroup: false)

// JSONEncoder() 로 singer -> jsonData 로 변환
let jsonEncoder = JSONEncoder()
jsonEncoder.outputFormatting = .prettyPrinted
let jsonData = try? jsonEncoder.encode(singer)
print(jsonData)

// JSONDecoder() 로 jsonData -> struct 로 변환
let jsonDecoder = JSONDecoder()
let decodedSinger = try? jsonDecoder.decode(Singer.self, from: jsonData!)
print(decodedSinger)
