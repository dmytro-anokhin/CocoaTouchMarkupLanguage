//
//  Label.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 01/05/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


class Label: UILabel {

    @objc
    var html: String? {
        didSet {
            guard let html = html else {
                text = nil
                return
            }

            guard let data = html.data(using: .utf8) else {
                text = nil
                return
            }

            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType : NSAttributedString.DocumentType.html,
                .characterEncoding : String.Encoding.utf8.rawValue
            ]

            let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
            text = attributedString?.string
        }
    }
}
