//
//  XMLNode+CustomStringConvertible.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


extension XMLNode: CustomStringConvertible {

    public var description: String {
        return name
    }
}
