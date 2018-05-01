//
//  ViewElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


class ViewElement: Element, PropertyElementType {

    override class var factory: ElementsFactoryType {
        return ViewElementsFactory()
    }

    private var _view: UIView?

    var view: UIView {
        if _view == nil {
            _view = loadView()
        }

        return _view!
    }

    var value: Any? {
        return view
    }

    var viewClass: UIView.Type {
        return objectClass as? UIView.Type ?? UIView.self
    }

    func loadView() -> UIView {
        let view = instantiateView()
        configureView(view)

        return view
    }

    func instantiateView() -> UIView {
        return viewClass.init()
    }

    func configureView(_ view: UIView) {
        for attribute in attributes {
            if Keywords.contains(attribute.key) {
                continue
            }

            applyAttribute(attribute.key, value: attribute.value, view: view)
        }

        for child in children {
            switch child {
                case let subview as ViewElement where subview.key == nil:
                    addSubview(subview, view: view)

                case let property as ElementType & PropertyElementType:
                    setProperty(property, view: view)

                default:
                    unknownChild(child, view: view)
            }
        }
    }

    func applyAttribute(_ name: String, value: String, view: UIView) {
        switch name {
            case "contentMode":
                guard let contentMode = UIViewContentMode(string: value) else {
                    print("Unknown value `\(value)` for `\(name)`")
                    return
                }

                view.contentMode = contentMode

            default:
                objc_do({
                        view.setValue(value, forKey: name)
                    }, { exception in
                        print(String(describing: exception))
                    })
        }
    }

    func setProperty(_ property: ElementType & PropertyElementType, view: UIView) {
        guard let key = property.key else {
            assertionFailure("Property element expected to have a key: \(property)")
            return
        }

        objc_do({
                view.setValue(property.value, forKey: key)
            }, { exception in
                print(String(describing: exception))
            })
    }

    func addSubview(_ subview: ViewElement, view: UIView) {
        switch view {
            case let stackView as UIStackView:
                stackView.addArrangedSubview(subview.view)

            default:
                view.addSubview(subview.view)
        }
    }

    func unknownChild(_ child: ElementType, view: UIView) {
        // print(child)
    }
}

