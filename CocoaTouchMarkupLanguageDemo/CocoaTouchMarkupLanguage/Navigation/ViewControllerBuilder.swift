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

    public var arguments: [String: Any] = [:]

    public init() {
    }

    public func build() throws -> UIViewController {
        guard let xmlNode = xmlNode else {
            throw Error.incomplete
        }

        do {
            let element = try ViewControllerElement(from: xmlNode)
            let viewController = element.viewController

            return viewController
        }
        catch {
            throw Error.element(underlyingError: error)
        }
    }
}
