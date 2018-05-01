//
//  ObjectControllerElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


class ObjectControllerElement: Element {

    private var _objectController: ObjectController?

    var objectController: ObjectController {
        if _objectController == nil {
            _objectController = loadObjectController()
        }

        return _objectController!
    }

    private func loadObjectController() -> ObjectController {

        let objectController = ObjectController()

        for child in children {
            switch child {
                case let property as ElementType & PropertyElementType:
                    guard let key = property.key else {
                        assertionFailure("Property element expected to have a key: \(property)")
                        break
                    }

                    objectController.setValue(property.value, forKey: key)

                default:
                    print(child)
            }
        }

        return objectController
    }
}
