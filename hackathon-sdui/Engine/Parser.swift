//
//  Parser.swift
//  hackathon-sdui
//
//  Created by Karun Pant on 11/05/23.
//

import Foundation

enum Result {
    case success(_ container: RenderableModel)
    case failure(_ error: ParsingError)
}

struct ParsingError: Error {
    let description: String
}


struct Parser {
    static func readJSON(fileName: String, onCompletion: (Result) -> ()) {
        var json: Any?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSONSerialization.jsonObject(with: data)
            } catch {
                onCompletion(.failure(ParsingError(description: error.localizedDescription)))
            }
        }
        if let parsedJSON = json as? [String: Any] {
            let model = RenderableModel(parsedJSON)
            onCompletion(.success(model))
        } else {
            onCompletion(.failure(ParsingError(description: "JSON object was nil.")))
        }
    }
}

struct ParsingHelper {
    static func asString(item: Any?) -> String {
        item as? String ?? ""
    }
    static func asBool(item: Any?) -> Bool {
        item as? Bool ?? false
    }
    static func asInt(item: Any?) -> Int {
        item as? Int ?? 0
    }
    static func propertiesDictionary(containerDictionary dictionary: [String: Any]?) -> [String: Any] {
        dictionary?["properties"] as? [String: Any] ?? [:]
    }
    static func asCGFloat(item: Any?) -> CGFloat {
        item as? CGFloat ?? 0
    }
    static func asURL(item: Any?) -> URL? {
        return URL(string: item as? String ?? "")
    }
}
