//
//  Parser.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import Foundation


public final class Parser: NSObject {

    public let url: URL

    public init(url: URL) {
        self.url = url
    }

    private lazy var xmlParser = XMLParser(contentsOf: url)

    private var root: XMLNode?

    public func parse(completion: @escaping (XMLNode?) -> Void) {
        self.completion = completion
        xmlParser?.delegate = self
        xmlParser?.parse()
    }

    fileprivate var completion: ((XMLNode?) -> Void)?

    fileprivate var stack: [XMLNode] = []

    fileprivate func updateLast(_ closure: (inout XMLNode) -> Void) {
        guard var last = stack.popLast() else {
            return
        }

        closure(&last)
        stack.append(last)
    }
}


extension Parser: XMLParserDelegate {

    public func parserDidEndDocument(_ parser: XMLParser) {
        completion?(root)
        completion = nil
    }

    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        var node = XMLNode(name: elementName)
        node.attributes = attributeDict

        stack.append(node)
    }

    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        let last = stack.popLast()!

        if stack.isEmpty {
            root = last
        }
        else {
            if var parent = stack.popLast() {
                parent.children.append(last)
                stack.append(parent)
            }
        }
    }

    public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        updateLast { $0.CDATA = CDATABlock }
    }
}

