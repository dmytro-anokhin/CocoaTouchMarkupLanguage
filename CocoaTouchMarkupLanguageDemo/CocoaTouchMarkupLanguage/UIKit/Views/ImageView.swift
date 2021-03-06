//
//  ImageView.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 29/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


/// The ImageView provides bogus loading image from URL implementation, suitable for demo but not real life usage. Real life implementation should provide local caching and prevent multiple loading image for same url.
class ImageView: UIImageView {

    static var queue = DispatchQueue(label: "CocoaTouchMarkupLanguage.ImageView")

    static let cache = NSCache<NSURL, UIImage>()

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
        if let cachedImage = ImageView.cache.object(forKey: url as NSURL) {
            self.image = cachedImage
            return
        }

        imageLoadURL = url

        let imageLoadWorkItem = DispatchWorkItem { [weak self] in
            var image: UIImage?

            do {
                let data = try Data(contentsOf: url)
                image = UIImage(data: data)
            }
            catch {
                print(error)
            }

            DispatchQueue.main.async {
                guard let `self` = self else {
                    return
                }

                if self.imageLoadURL == url {
                    self.image = image
                    self.imageLoadURL = nil

                    if let imageToCache = image {
                        ImageView.cache.setObject(imageToCache, forKey: url as NSURL)
                    }
                }
            }
        }

        self.imageLoadWorkItem = imageLoadWorkItem
        ImageView.queue.async(execute: imageLoadWorkItem)
    }
}
