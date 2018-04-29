//
//  ObservationToken.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


class ObservationToken: ObservationTokenType {

    let closure: (_ object: KeyValueCoding, _ keyPath: String) -> Void

    let keyPath: String

    init(closure: @escaping (_ object: KeyValueCoding, _ keyPath: String) -> Void, keyPath: String) {
        self.closure = closure
        self.keyPath = keyPath
    }

    let id = UUID()

    var enabled: Bool = true
}


extension ObservationToken: Equatable {

    public static func == (lhs: ObservationToken, rhs: ObservationToken) -> Bool {
        return lhs.id == rhs.id && lhs.keyPath == rhs.keyPath
    }
}


extension ObservationToken: Hashable {

    public var hashValue: Int {
        return id.hashValue
    }
}
