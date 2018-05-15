//
//  PropertyElementType.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


protocol PropertyElementType {

    var key: String? { get }

    var value: Any? { get }
}


extension ElementType where Self: PropertyElementType {

    var key: String? {
        return attributes.first { $0.key == "key" }?.value
    }

    var value: Any? {
        return instance
    }
}
