//
//  ScrollView.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 01/05/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import Foundation


class ScrollView: UIScrollView, ContainerViewType {

    // MARK: ContainerViewType

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

    var relativeToMargins: Bool = false {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    var relativeToReadableContent: Bool = false {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    var relativeToSafeArea: Bool = false {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    // MARK: NSKeyValueCoding

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if !set(value: value, forKey: key) {
            super.setValue(value, forUndefinedKey: key)
        }
    }

    // MARK: UIConstraintBasedLayoutCoreMethods

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

        assert(!relativeToReadableContent, "relativeToReadableContent not supported yet")
        assert(!relativeToSafeArea, "relativeToSafeArea not supported yet")

        let margins = relativeToMargins ? layoutMargins : .zero

        let constraints = [
            managedView.topAnchor.constraint(equalTo: topAnchor, constant: margins.top),
            managedView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margins.left),
            managedView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0 * margins.bottom),
            managedView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.0 * margins.right),

            managedView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0)
        ]

        NSLayoutConstraint.activate(constraints)
        currentConstraints = constraints
    }

    // MARK: UIViewHierarchy

    private var heightConstraint: NSLayoutConstraint?

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        heightConstraint?.isActive = false
        heightConstraint = nil
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        if let superview = superview {
            heightConstraint = heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 1.0)
            heightConstraint?.isActive = true
        }
    }
}
