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

    public func parserDidStartDocument(_ parser: XMLParser) {
        print("parserDidStartDocument")
    }

    public func parserDidEndDocument(_ parser: XMLParser) {
        print("parserDidEndDocument")
        completion?(root)
        completion = nil
    }

    public func parser(_ parser: XMLParser, foundNotationDeclarationWithName name: String, publicID: String?, systemID: String?)  {
        print("foundNotationDeclarationWithName")
    }

    public func parser(_ parser: XMLParser, foundUnparsedEntityDeclarationWithName name: String, publicID: String?, systemID: String?, notationName: String?) {
        print("foundUnparsedEntityDeclarationWithName")
    }

    public func parser(_ parser: XMLParser, foundAttributeDeclarationWithName attributeName: String, forElement elementName: String, type: String?, defaultValue: String?) {
        print("foundAttributeDeclarationWithName")
    }

    public func parser(_ parser: XMLParser, foundElementDeclarationWithName elementName: String, model: String) {
        print("foundElementDeclarationWithName")
    }

    public func parser(_ parser: XMLParser, foundInternalEntityDeclarationWithName name: String, value: String?) {
        print("foundInternalEntityDeclarationWithName")
    }

    public func parser(_ parser: XMLParser, foundExternalEntityDeclarationWithName name: String, publicID: String?, systemID: String?) {
        print("foundExternalEntityDeclarationWithName")
    }

    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        print("didStartElement \(elementName)")
        var node = XMLNode(name: elementName)
        node.attributes = attributeDict

        stack.append(node)
    }

    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("didEndElement \(elementName)")
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

    public func parser(_ parser: XMLParser, didStartMappingPrefix prefix: String, toURI namespaceURI: String) {
        print("didStartMappingPrefix")
    }

    public func parser(_ parser: XMLParser, didEndMappingPrefix prefix: String) {
        print("didEndMappingPrefix")
    }

    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        print("foundCharacters")
    }

    public func parser(_ parser: XMLParser, foundIgnorableWhitespace whitespaceString: String) {
        print("foundIgnorableWhitespace")
    }

    public func parser(_ parser: XMLParser, foundProcessingInstructionWithTarget target: String, data: String?) {
        print("foundProcessingInstructionWithTarget")
    }

    public func parser(_ parser: XMLParser, foundComment comment: String) {
        print("foundComment")
    }

    public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        print("foundCDATA")
        updateLast { $0.CDATA = CDATABlock }
    }

    public func parser(_ parser: XMLParser, resolveExternalEntityName name: String, systemID: String?) -> Data? {
        print("resolveExternalEntityName")
        return nil
    }

    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred")
    }

    public func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        print("validationErrorOccurred")
    }
}

