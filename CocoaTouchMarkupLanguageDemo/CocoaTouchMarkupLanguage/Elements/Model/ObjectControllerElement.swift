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

        let bundleResourceElement = children.first { $0 is BundleResourceElement } as? BundleResourceElement
        let url = bundleResourceElement?.url

        if let url = url {
            do {
                let data = try Data(contentsOf: url)
                return try ObjectController.json(data)
            }
            catch {
                preconditionFailure(String(describing: error))
            }
        }

        return ObjectController()
    }
}
