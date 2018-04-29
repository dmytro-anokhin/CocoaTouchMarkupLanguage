//
//  ViewController.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var viewPrototypeElement: ViewPrototypeElement?
    var objectControllerElement: ObjectControllerElement?

    private var viewElement: ViewElement?

    override func loadView() {
        guard let viewPrototypeElement = viewPrototypeElement else {
            assertionFailure("ViewController must have a prototype")
            super.loadView()
            return
        }

        let viewElement = viewPrototypeElement.viewElement
        self.view = viewElement.view
        self.viewElement = viewElement
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        representedObject = objectControllerElement?.objectController

        if let viewElement = viewElement,
           let objectController = representedObject
        {
            bindingTokens = connect(viewElement: viewElement, objectController: objectController)
        }
    }

    var representedObject: ObjectController?

    private var bindingTokens: [ObservationTokenType]?
}
