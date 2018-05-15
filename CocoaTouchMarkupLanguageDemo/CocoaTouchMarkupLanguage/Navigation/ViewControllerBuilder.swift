//
//  ViewControllerBuilder.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 01/05/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


public struct ViewControllerBuilder {

    public enum Error: Swift.Error {

        case incomplete

        case element(underlyingError: Swift.Error)
    }

    public var xmlNode: XMLNode?

    public var arguments: [String: Any?] = [:]

    public init() {
    }

    public func build() throws -> UIViewController {
        guard let xmlNode = xmlNode else {
            throw Error.incomplete
        }

        do {
            let element = try ViewControllerElement(from: xmlNode)

            guard let viewController = element.viewController as? ViewController else {
                throw Error.incomplete
            }

            viewController.representedObject?.setValue((arguments as NSDictionary).mutableCopy(), forKey: "arguments")

            if let objectController = viewController.representedObject {
                let tokens = connect(viewControllerElement: element, objectController: objectController)
                viewController.bindingTokens = tokens
            }

            return viewController
        }
        catch {
            throw Error.element(underlyingError: error)
        }
    }
}
