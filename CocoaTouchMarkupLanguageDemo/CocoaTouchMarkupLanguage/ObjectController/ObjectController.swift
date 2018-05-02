//
//  ObjectController.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 26/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import Foundation


/// A controller that provides loose key-value observing for the content.
public class ObjectController: LooseKeyValueObservable, LooseKeyValueObservableDelegating {

    /// A Key-Value Codable and Observable object, typically an NSMutableDictionary.
    let content: NSObject

    public convenience init() {
        self.init(NSMutableDictionary())
    }

    public init(_ content: NSObject & NSMutableCopying) {
        let mutableCopy = content.mutableCopy()
        
        guard let mutableCopyNSObject = mutableCopy as? NSObject else {
            fatalError("Mutable copy of the content must be NSObject instance. Original content: \(content), mutable copy: \(mutableCopy)")
        }
        
        self.content = mutableCopyNSObject
        (observationDelegate as! ObservationController).owner = self
    }

    deinit {
        (observationDelegate as! ObservationController).cleanup(self)
    }

    // MARK: LooseKeyValueObservableDelegating

    public let observationDelegate: LooseKeyValueObservable = ObservationController()
}


extension ObjectController: KeyValueObserverRegistration {

    func addObserver(_ observer: NSObject, forKeyPath keyPath: String, options: NSKeyValueObservingOptions, context: UnsafeMutableRawPointer?) {
        content.addObserver(observer, forKeyPath: keyPath, options: options, context: context)
    }

    func removeObserver(_ observer: NSObject, forKeyPath keyPath: String, context: UnsafeMutableRawPointer?) {
        content.removeObserver(observer, forKeyPath: keyPath, context: context)
    }
}

extension ObjectController: KeyValueCoding {

    public func value(forKey key: String) -> Any? {
        if key == "self" {
            return content
        }
        
        return content.value(forKeyPath: key)
    }

    public func setValue(_ value: Any?, forKey key: String) {
        content.setValue(value, forKeyPath: key)
    }
}

