//
//  TextField.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


class TextField: UITextField, LooseKeyValueObservable, LooseKeyValueObservableDelegating {

    override init(frame: CGRect) {
        super.init(frame: frame)
        init_TextField()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        init_TextField()
    }

    private func init_TextField() {
        addTarget(self, action: #selector(editingChangedHandler), for: .editingChanged)
        (observationDelegate as! ObservationController).owner = self
    }

    deinit {
        (observationDelegate as! ObservationController).cleanup(self)
    }

    @objc private func editingChangedHandler() {
        (observationDelegate as! ObservationController).notifyValueChange(for: "text")
    }

    // MARK: LooseKeyValueObservableDelegating

    public let observationDelegate: LooseKeyValueObservable = ObservationController()
}
