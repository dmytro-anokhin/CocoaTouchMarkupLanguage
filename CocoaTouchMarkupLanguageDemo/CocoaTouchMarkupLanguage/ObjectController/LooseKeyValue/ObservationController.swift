//
//  ObservationController.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 27/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import Foundation


final class ObservationController: NSObject, LooseKeyValueObservable {

    private static var kvoContext = 0

    private var observationsMap = [String: Set<ObservationToken>]()

    /// The object observed by the `ObservationController` instance. The `owner` must be set before using `ObservationController` methods.
    weak var owner: (KeyValueObserverRegistration & KeyValueCoding)!

    /// The `cleanup` method called from owner's deinit. Weak reference is removed at this point. Owner must be passed as argument.
    func cleanup(_ owner: KeyValueObserverRegistration & KeyValueCoding) {
        for keyPath in observationsMap.keys {
            if keyPath.range(of: "@") == nil {
                owner.removeObserver(self, forKeyPath: keyPath, context: &ObservationController.kvoContext)
            }
        }
    }

    func notifyValueChange(for keyPath: String) {
        guard let observations = observationsMap[keyPath] else {
            return
        }

        for observation in observations where observation.enabled {
            observation.closure(owner, keyPath)
        }
    }

    // MARK: NSKeyValueObserving

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        print("observeValue(forKeyPath: \(keyPath ?? "nil"), of: \(object ?? "nil"), change: \(change ?? [:] ), context: \(String(describing: context)))")

        guard context == &ObservationController.kvoContext else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }

        notifyValueChange(for: keyPath!)
    }

    // MARK: LooseKeyValueObservable

    func observe(_ keyPath: String, changeHandler: @escaping (KeyValueCoding, String) -> Void) -> ObservationTokenType {
        var observations: Set<ObservationToken>

        if let existing = observationsMap[keyPath] {
            observations = existing
        }
        else {
            observations = Set<ObservationToken>()

            if keyPath.range(of: "@") == nil {
                owner.addObserver(self, forKeyPath: keyPath, options: [], context: &ObservationController.kvoContext)
            }
        }

        let observation = ObservationToken(closure: changeHandler, keyPath: keyPath)
        observations.insert(observation)
        observationsMap[keyPath] = observations

        return observation
    }

    func remove(observation: ObservationTokenType) {
        guard let observation = observation as? ObservationToken else {
            fatalError("Unexpected observation")
        }

        guard var observations = observationsMap[observation.keyPath] else {
            return
        }

        observations.remove(observation)
        observationsMap[observation.keyPath] = observations
    }
}
