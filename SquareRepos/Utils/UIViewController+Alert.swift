//
//  UIViewController+Alert.swift
//  SquareRepos
//
//  Created by Alexander Spirichev on 15/10/2017.
//  Copyright © 2017 Alexander Spirichev. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  func showAlert(with error: Error) {
    let alert = UIAlertController(title: error.descriptionValue.title, message: error.descriptionValue.message, preferredStyle: .alert)
    let tryLaterAction = UIAlertAction(title: "Try again later", style: .default, handler: nil)
    alert.addAction(tryLaterAction)
    present(alert, animated: true, completion: nil)
  }
}
