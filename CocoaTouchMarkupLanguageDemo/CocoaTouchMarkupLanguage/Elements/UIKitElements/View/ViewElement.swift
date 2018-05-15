//
//  ViewElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


class ViewElement: Element, PropertyElementType, ViewElementType {

    // MARK: Element

    override class var factory: ElementsFactoryType {
        return ViewElementsFactory()
    }

    // MARK: Loading

    override func instantiate() -> Any? {
        return viewClass.init()
    }

    override func processChild(_ child: ElementType, instance: Any) {
        guard let view = instance as? UIView else {
            fatalError("Expected \(type(of: UIView.self)), got: \(instance)")
        }

        switch child {
            case let subview as ViewElement where subview.key == nil:
                addSubview(subview, view: view)

            default:
                super.processChild(child, instance: instance)
        }
    }

    override func applyAttribute(name: String, value: String, instance: Any) {
        guard let view = instance as? UIView else {
            fatalError("Expected \(type(of: UIView.self)), got: \(instance)")
        }

        switch name {
            case "contentMode":
                guard let contentMode = UIViewContentMode(string: value) else {
                    print("Unknown value `\(value)` for `\(name)`")
                    return
                }

                view.contentMode = contentMode

            default:
                super.applyAttribute(name: name, value: value, instance: instance)
        }
    }

    // MARK: Internal

    var viewClass: UIView.Type {
        return objectClass as? UIView.Type ?? UIView.self
    }

    func addSubview(_ subview: ViewElement, view: UIView) {
        switch view {
            case let stackView as UIStackView:
                stackView.addArrangedSubview(subview.view)

            default:
                view.addSubview(subview.view)
        }
    }
}
