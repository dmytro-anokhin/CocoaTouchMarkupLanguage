//
//  Keywords.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


struct Keywords {

    static func contains(_ string: String) -> Bool {
        let all: Set<String> = [ Keywords.className.lowercased(), Keywords.key.lowercased() ]
        return all.contains(string.lowercased())
    }

    static let className = "className"

    static let key = "key"
}
