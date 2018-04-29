//
//  ImageView.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 29/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


/// The ImageView provides basic loading image from URL implementation, suitable for demo but not real life usage.
class ImageView: UIImageView {

    static var queue = DispatchQueue(label: "CocoaTouchMarkupLanguage.ImageView")

    @objc var imageName: String? {
        didSet {
            guard let imageName = imageName else {
                image = nil
                return
            }

            image = UIImage(named: imageName)
        }
    }

    @objc var imagePath: String? {
        willSet {
            cancelImageLoading()
            image = nil
        }

        didSet {
            guard let imagePath = imagePath else {
                return
            }

            let url = URL(fileURLWithPath: imagePath)
            loadImage(with: url)
        }
    }

    @objc var imageURL: String? {
        willSet {
            cancelImageLoading()
            image = nil
        }

        didSet {
            guard let imageURL = imageURL,
                  let url = URL(string: imageURL)
            else {
                return
            }

            loadImage(with: url)
        }
    }

    deinit {
        cancelImageLoading()
    }

    private var imageLoadWorkItem: DispatchWorkItem?
    private var imageLoadURL: URL?

    private func cancelImageLoading() {
        imageLoadWorkItem?.cancel()
        imageLoadWorkItem = nil
        imageLoadURL = nil
    }

    private func loadImage(with url: URL) {
        imageLoadURL = url

        let imageLoadWorkItem = DispatchWorkItem { [weak self] in
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)

                DispatchQueue.main.async {
                    guard let `self` = self else {
                        return
                    }

                    if self.imageLoadURL == url {
                        self.image = image
                        self.imageLoadURL = nil
                    }
                }
            }
            catch {
                print(error)
            }
        }

        self.imageLoadWorkItem = imageLoadWorkItem
        ImageView.queue.async(execute: imageLoadWorkItem)
    }
}
