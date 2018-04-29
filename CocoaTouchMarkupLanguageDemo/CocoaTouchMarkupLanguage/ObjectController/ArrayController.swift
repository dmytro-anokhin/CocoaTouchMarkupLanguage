//
//  ArrayController.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 26/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import Foundation


final class ArrayController: ObjectController {

    fileprivate var array: NSMutableArray {
        return content as! NSMutableArray
    }

    public convenience init() {
        self.init(NSMutableArray())
    }

    public override init(_ content: NSObject & NSMutableCopying) {
        guard content is NSArray else {
            fatalError("Expected NSArray, got: \(content)")
        }
        
        super.init(content)
    }
}


extension ArrayController {

    var arrangedObjects: [Any] {
        return array as! [Any]
    }

    var count: Int {
        return array.count
    }

    subscript(index: Int) -> Any {
        get {
            return array[index]
        }
        
        set {
            array[index] = newValue
        }
    }
}
