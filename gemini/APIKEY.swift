//
//  APKEY.swift
//  gemini
//
//  Created by 堀内翔矢 on 2024/01/12.
//

import Foundation

enum APKEY{
    
    static var `default` : String {
        guard let filepath = Bundle.main.path(forResource: "GenerativeAI-Info", ofType: "plist")
        else {
            fatalError("Couldn7t find file'GenerativeAI-Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filepath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn7t find key 'API_KEY' in 'GenerativeAI-Info.plist'.")
        }
        if value.starts(with: "_") {
            fatalError(
                "Follow the instructions at http://ai.google.dev/tutorials/setup to get an API key.")
        }
        return value
    }
}
