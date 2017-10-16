//
//  RepositoryTableViewCell.swift
//  SquareRepos
//
//  Created by Alexander Spirichev on 14/10/2017.
//  Copyright © 2017 Alexander Spirichev. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

  @IBOutlet weak var repositoryNameLabel: UILabel!
  @IBOutlet weak var starsCountLabel: UILabel!
  @IBOutlet weak var forksCountLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  func configure(withRepo repos: Repository) {
    repositoryNameLabel.text = repos.name
    starsCountLabel.text = "stars \(repos.starsCount)"
    forksCountLabel.text = "forks \(repos.forksCount)"
    descriptionLabel.text = repos.description
  }

}
