//
//  ScrollView.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 01/05/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import Foundation


class ScrollView: UIScrollView {

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

        let margins = relativeToMargins ? layoutMargins : .zero

        let constraints = [
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: margins.top),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margins.left),
            contentView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -1.0 * margins.bottom),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.0 * margins.right),

            contentView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0)
        ]

        NSLayoutConstraint.activate(constraints)
        currentConstraints = constraints
    }

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
