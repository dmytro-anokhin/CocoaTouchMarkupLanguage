//
//  ViewController.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


public class ViewController: UIViewController {

    var viewPrototypeElement: ViewPrototypeElement?

    var objectControllerElement: ObjectControllerElement? {
        didSet {
            representedObject = objectControllerElement?.objectController
        }
    }

    private var viewElement: ViewElement?

    public override func loadView() {
        guard let viewPrototypeElement = viewPrototypeElement else {
            assertionFailure("ViewController must have a prototype")
            super.loadView()
            return
        }

        let viewElement = viewPrototypeElement.viewElement
        self.view = viewElement.view
        self.viewElement = viewElement
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        if let viewElement = viewElement,
           let objectController = representedObject
        {
            let tokens = connect(viewElement: viewElement, objectController: objectController)
            bindingTokens.append(contentsOf: tokens)
        }
    }

    var representedObject: ObjectController?

    var bindingTokens: [ObservationTokenType] = []
}
