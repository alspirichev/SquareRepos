//
//  ContributorTableViewCell.swift
//  SquareRepos
//
//  Created by Alexander Spirichev on 15/10/2017.
//  Copyright © 2017 Alexander Spirichev. All rights reserved.
//

import UIKit

class ContributorTableViewCell: UITableViewCell {
  
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var userTypeLabel: UILabel!

  func configureWith(contributor: Contributor) {
    usernameLabel.text = contributor.login
    userTypeLabel.text = "Type: \(contributor.type)"

    ImageCache.shared.loadAvatar(by: contributor.avatarURL) { [unowned self] image in
      self.avatarImageView.image = image
    }
  }
}
