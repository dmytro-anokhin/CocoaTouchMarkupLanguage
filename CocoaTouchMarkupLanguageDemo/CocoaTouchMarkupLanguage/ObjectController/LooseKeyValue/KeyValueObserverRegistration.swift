//
//  KeyValueObserverRegistration.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import Foundation


/// Key methods from NSKeyValueObserverRegistration category declared as a protocol to remove NSObject requirement.
protocol KeyValueObserverRegistration: class {

    func addObserver(_ observer: NSObject, forKeyPath keyPath: String, options: NSKeyValueObservingOptions, context: UnsafeMutableRawPointer?)

    func removeObserver(_ observer: NSObject, forKeyPath keyPath: String, context: UnsafeMutableRawPointer?)
}


extension NSObject: KeyValueObserverRegistration {
}
