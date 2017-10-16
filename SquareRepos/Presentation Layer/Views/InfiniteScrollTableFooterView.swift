//
//  InfiniteScrollTableFooterView.swift
//  SquareRepos
//
//  Created by Alexander Spirichev on 16/10/2017.
//  Copyright © 2017 Alexander Spirichev. All rights reserved.
//

import UIKit

class InfiniteScrollTableFooterView: UIView {

  @IBOutlet var activityIndicator: UIActivityIndicatorView!

  override func awakeFromNib() {
    activityIndicator.startAnimating()
  }
}
