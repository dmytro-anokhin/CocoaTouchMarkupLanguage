//
//  KeyValueCoding.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import Foundation


// Key methods from NSKeyValueCoding category declared as a protocol to remove NSObject requirement.
public protocol KeyValueCoding: class {

    func value(forKey key: String) -> Any?

    func setValue(_ value: Any?, forKey key: String)
}


extension NSObject: KeyValueCoding {
}
