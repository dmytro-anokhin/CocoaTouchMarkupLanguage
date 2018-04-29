//
//  KeyValueBinding.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


func connect(viewElement rootViewElement: ViewElement, objectController: ObjectController) -> [ObservationTokenType] {

    var tokens: [ObservationTokenType] = []

    var viewElements = [rootViewElement]

    while !viewElements.isEmpty {
        let viewElement = viewElements.removeFirst()

        // process viewElement
        for case let binding as BindingElement in viewElement.children {
            guard let name = binding.attributes["name"],
                  let keyPath = binding.attributes["keyPath"]
            else {
                assertionFailure("Binding \(binding) must contain name and keyPath")
                continue
            }

            let token1 = objectController.observe(keyPath) { [weak viewElement] objectController, objectControllerKeyPath in
                guard let viewElement = viewElement else {
                    return
                }

                let value = objectController.value(forKey: objectControllerKeyPath)
                viewElement.view.setValue(value, forKey: name)
            } as! ObservationToken

            tokens.append(token1)

            if let looseKVOObservable = viewElement.view as? LooseKeyValueObservable {
                let token2 = looseKVOObservable.observe(name) { [weak token1, weak objectController] view, viewKeyPath in
                    guard let token1 = token1,
                          let objectController = objectController
                    else {
                        return
                    }

                    token1.enabled = false

                    let value = view.value(forKey: viewKeyPath)
                    objectController.setValue(value, forKey: keyPath)

                    token1.enabled = true
                } as! ObservationToken

                tokens.append(token2)
            }

            // Initial
            let value = objectController.value(forKey: keyPath)
            viewElement.view.setValue(value, forKey: name)
        }

        var subviewElements: [ViewElement] = []

        for element in viewElement.children {
            if let subviewElement = element as? ViewElement {
                subviewElements.append(subviewElement)
            }
            else if let subviewsElement = element as? SubviewsElement {
                subviewElements.append(contentsOf: subviewsElement.children.compactMap({ $0 as? ViewElement }))
            }
        }

        viewElements.append(contentsOf: subviewElements)
    }

    return tokens
}


func disconnect(view rootView: UIView, objectController: ObjectController, tokens: [ObservationTokenType]) {

    for token in tokens {
        objectController.remove(observation: token)
    }

    var views = [rootView]

    while !views.isEmpty {
        let view = views.removeFirst()

        // process viewElement
        if let looseKVOObservable = view as? LooseKeyValueObservable {
            for token in tokens {
                looseKVOObservable.remove(observation: token)
            }
        }

        views.append(contentsOf: view.subviews)
    }
}
