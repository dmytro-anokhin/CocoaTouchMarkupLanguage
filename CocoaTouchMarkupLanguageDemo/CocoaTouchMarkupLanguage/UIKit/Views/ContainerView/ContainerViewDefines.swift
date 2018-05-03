//
//  ContainerViewDefines.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 03/05/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

enum ContainerViewAlignment {

    case center

    static var top: ContainerViewAlignment { return .leading }

    case leading

    static var bottom: ContainerViewAlignment { return .trailing }

    case trailing

    static var `default`: ContainerViewAlignment { return .center }

    public init(string: String) {
        switch string.lowercased() {
            case "center":
                self = .center
            case "leading":
                self = .leading
            case "bottom":
                self = .bottom
            case "trailing":
                self = .trailing
            default:
                self = .default
        }
    }
}
