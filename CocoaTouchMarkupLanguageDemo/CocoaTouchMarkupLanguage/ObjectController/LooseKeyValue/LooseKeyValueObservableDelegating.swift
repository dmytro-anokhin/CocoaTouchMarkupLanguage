//
//  LooseKeyValueObservableDelegating.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


/// The protocol for objects that delegate loose key-value observation mechanism to the `observationDelegate`.
public protocol LooseKeyValueObservableDelegating {

    var observationDelegate: LooseKeyValueObservable { get }
}


// The `LooseKeyValueObservable` object can delegate loose key-value observation mechanism
extension LooseKeyValueObservable where Self: LooseKeyValueObservableDelegating {

    public func observe(_ keyPath: String, changeHandler: @escaping (_ object: KeyValueCoding, _ keyPath: String) -> Void) -> ObservationTokenType {
        return observationDelegate.observe(keyPath, changeHandler: changeHandler)
    }

    public func remove(observation: ObservationTokenType) {
        observationDelegate.remove(observation: observation)
    }
}
