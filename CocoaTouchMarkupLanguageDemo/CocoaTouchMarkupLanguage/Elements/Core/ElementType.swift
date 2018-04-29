//
//  ElementType.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

public protocol ElementType {

    var name: String { get }

    var children: [ElementType] { get }

    var attributes: [String: String] { get }
}


extension ElementType {

    func visit(_ visitor: (ElementType) -> Void) {
        var stack: [ElementType] = [ self ]

        while !stack.isEmpty {
            let element = stack.popLast()!
            visitor(element)
            stack.append(contentsOf: element.children.reversed())
        }
    }
}
