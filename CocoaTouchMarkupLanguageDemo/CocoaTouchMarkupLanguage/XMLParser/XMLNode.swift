//
//  XMLNode.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


public struct XMLNode {

    let name: String

    var value: String?

    var children: [XMLNode] = []

    var attributes: [String: String] = [:]

    var CDATA: Data?

    init(name: String) {
        self.name = name
    }
}


extension XMLNode {

    func children(named name: String) -> [XMLNode] {
        return children.filter { $0.name == name }
    }
}
