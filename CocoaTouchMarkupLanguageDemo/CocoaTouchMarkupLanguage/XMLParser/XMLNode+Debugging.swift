//
//  XMLNode+Debugging.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


extension XMLNode {

    var recursivedDescription: String {
        return recursivedDescription(level: 0)
    }

    private func recursivedDescription(level: Int) -> String {
        var result = Array(repeating: " ", count: level).joined(separator: "") + description

        if children.count > 0 {
            result += children.reduce("") {
                $0 + "\n" + $1.recursivedDescription(level: level + 1)
            }
        }

        return result
    }
}
