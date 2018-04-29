//
//  ObjectController+JSON.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 26/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import Foundation


public extension ObjectController {

    public enum JSONError: Error {
        case notSupported
    }

    public class func json(_ json: Data) throws -> ObjectController {
        let jsonObject = try JSONSerialization.jsonObject(with: json, options: [])

        guard let content = jsonObject as? NSObject & NSMutableCopying else {
            throw JSONError.notSupported
        }

        if let array = content as? NSArray {
            return ArrayController(array)
        }
        else {
            return ObjectController(content)
        }
    }
}
