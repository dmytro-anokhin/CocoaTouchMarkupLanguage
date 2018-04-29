//
//  LooseKeyValueObservable.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 26/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


/// The `LooseKeyValueObservable` is a protocol for objects that support Key-Value Observing using `String` key-paths.
public protocol LooseKeyValueObservable {

    func observe(_ keyPath: String, changeHandler: @escaping (_ object: KeyValueCoding, _ keyPath: String) -> Void) -> ObservationTokenType
    
    func remove(observation: ObservationTokenType)
}

/// A token used by observable objects to manage list of observations.
public protocol ObservationTokenType {
}
