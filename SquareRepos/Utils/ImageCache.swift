//
//  ImageCache.swift
//  SquareRepos
//
//  Created by Alexander Spirichev on 15/10/2017.
//  Copyright © 2017 Alexander Spirichev. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {

  private static let _shared = ImageCache()
  var images = [String: UIImage]()

  static var shared: ImageCache {
    return _shared
  }

  init() {
    NotificationCenter.default.addObserver(forName: Notification.Name.UIApplicationDidReceiveMemoryWarning, object: nil, queue: .main) { [weak self] notification in
      self?.images.removeAll(keepingCapacity: false)
    }
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  // MARK: Action

  func loadAvatar(by url: URL, completion: @escaping (UIImage) -> Void) {
    if let image = ImageCache.shared.image(forKey: url.absoluteString) {
      completion(image)
    } else {
      URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
        guard let data = data, error == nil else { return }
        let newImage = UIImage(data: data)
        ImageCache.shared.set(newImage!, forKey: url.absoluteString)

        OperationQueue.main.addOperation {
          completion(newImage!)
        }
      }).resume()
    }
  }

}

extension ImageCache {
  func set(_ image: UIImage, forKey key: String) {
    images[key] = image
  }

  func image(forKey key: String) -> UIImage? {
    return images[key]
  }
}
