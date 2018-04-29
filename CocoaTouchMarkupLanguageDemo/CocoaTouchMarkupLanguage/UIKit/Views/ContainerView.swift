//
//  ContainerView.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


enum ContainerViewAlignment {

    case center

    case leading

    case top

    public init?(string: String) {
        #if swift(>=4.2)
            // Swift 4.2 supposed to implement "Derived Collection of Enum Cases"
            // #error https://github.com/apple/swift-evolution/blob/master/proposals/0194-derived-collection-of-enum-cases.md
            // #warning
        #else
            switch string.lowercased() {
                case String(describing: ContainerViewAlignment.center).lowercased():
                    self = .center
                case String(describing: ContainerViewAlignment.leading).lowercased():
                    self = .leading
                case String(describing: ContainerViewAlignment.top).lowercased():
                    self = .top
                default:
                    return nil
            }
        #endif
    }
}


extension ContainerViewAlignment: CustomStringConvertible {

    public var description: String {
        switch self {
            case .center:
                return "center"
            case .leading:
                return "leading"
            case .top:
                return "top"
        }
    }
}


class ContainerView: UIView {

    @objc var contentView: UIView? {
        willSet{
            contentView?.removeFromSuperview()
        }

        didSet {
            guard let contentView = contentView else {
                return
            }

            contentView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(contentView)
        }
    }

    var alignment: ContainerViewAlignment = .center {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    override func setValue(_ value: Any?, forKey key: String) {
        if let value = value as? String, key == "alignment" {
            if let alignment = ContainerViewAlignment(string: value) {
                self.alignment = alignment
            }
            else {
                // TODO: error
            }

            return
        }

        super.setValue(value, forKey: key)
    }

    @objc var relativeToMargins: Bool = false {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    private var currentConstraints: [NSLayoutConstraint]?

    override func updateConstraints() {
        super.updateConstraints()

        if let constraints = currentConstraints {
            NSLayoutConstraint.deactivate(constraints)
            currentConstraints = nil
        }

        guard let contentView = contentView else {
            return
        }

        let constraints: [NSLayoutConstraint]

        let margins = relativeToMargins ? layoutMargins : .zero

        switch alignment {
            case .center:
                constraints = [
                    contentView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: margins.top),
                    contentView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: margins.left),
                    contentView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -1.0 * margins.bottom),
                    contentView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -1.0 * margins.right),

                    contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
                    contentView.centerYAnchor.constraint(equalTo: centerYAnchor)
                ]
            case .leading:
                constraints = [
                    contentView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: margins.top),
                    contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margins.left),
                    contentView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -1.0 * margins.bottom),
                    contentView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -1.0 * margins.right),

                    contentView.centerYAnchor.constraint(equalTo: centerYAnchor)
                ]
            case .top:
                constraints = [
                    contentView.topAnchor.constraint(equalTo: topAnchor, constant: margins.top),
                    contentView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: margins.left),
                    contentView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -1.0 * margins.bottom),
                    contentView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -1.0 * margins.right),

                    contentView.centerXAnchor.constraint(equalTo: centerXAnchor)
                ]
        }

        NSLayoutConstraint.activate(constraints)
        currentConstraints = constraints
    }

    override var intrinsicContentSize: CGSize {
        return contentView?.intrinsicContentSize ?? super.intrinsicContentSize
    }
}
