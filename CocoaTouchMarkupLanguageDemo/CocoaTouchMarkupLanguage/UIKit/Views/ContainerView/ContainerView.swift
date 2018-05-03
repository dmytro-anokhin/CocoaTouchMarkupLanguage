//
//  ContainerView.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


class ContainerView: UIView, ContainerViewType {

    var managedView: UIView? {
        willSet{
            managedView?.removeFromSuperview()
        }

        didSet {
            guard let managedView = managedView else {
                return
            }

            managedView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(managedView)
        }
    }

    var horizontalAlignment: ContainerViewAlignment = .default {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    var verticalAlignment: ContainerViewAlignment = .default {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    var relativeToMargins: Bool = false {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if set(value: value, forKey: key) {
            // noop
        }
        else {
            super.setValue(value, forUndefinedKey: key)
        }
    }

    private var currentConstraints: [NSLayoutConstraint]?

    override func updateConstraints() {
        super.updateConstraints()

        if let constraints = currentConstraints {
            NSLayoutConstraint.deactivate(constraints)
            currentConstraints = nil
        }

        guard let managedView = managedView else {
            return
        }

        let margins = relativeToMargins ? layoutMargins : .zero

        var constraints: [NSLayoutConstraint] = []

        switch horizontalAlignment {
            case .center:
                constraints += [
                    managedView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: margins.left),
                    managedView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -1.0 * margins.bottom),
                    managedView.centerXAnchor.constraint(equalTo: centerXAnchor)
                ]
            case .leading:
                constraints += [
                    managedView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margins.left),
                    managedView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -1.0 * margins.bottom)
                ]
            case .trailing:
                constraints += [
                    managedView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: margins.left),
                    managedView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.0 * margins.bottom)
                ]
        }

        switch verticalAlignment {
            case .center:
                constraints += [
                    managedView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: margins.top),
                    managedView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -1.0 * margins.bottom),
                    managedView.centerYAnchor.constraint(equalTo: centerYAnchor)
                ]
            case .leading:
                constraints += [
                    managedView.topAnchor.constraint(equalTo: topAnchor, constant: margins.top),
                    managedView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -1.0 * margins.bottom)
                ]
            case .trailing:
                constraints += [
                    managedView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: margins.top),
                    managedView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0 * margins.bottom)
                ]
        }

        NSLayoutConstraint.activate(constraints)
        currentConstraints = constraints
    }

    override var intrinsicContentSize: CGSize {
        return managedView?.intrinsicContentSize ?? super.intrinsicContentSize
    }
}
