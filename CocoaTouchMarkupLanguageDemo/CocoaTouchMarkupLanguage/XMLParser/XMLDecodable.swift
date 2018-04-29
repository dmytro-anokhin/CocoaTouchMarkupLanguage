//
//  XMLDecodable.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


public protocol XMLDecodable {

    init(from xmlNode: XMLNode) throws
}
