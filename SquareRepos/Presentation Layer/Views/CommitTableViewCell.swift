//
//  CommitTableViewCell.swift
//  SquareRepos
//
//  Created by Alexander Spirichev on 15/10/2017.
//  Copyright © 2017 Alexander Spirichev. All rights reserved.
//

import UIKit

class CommitTableViewCell: UITableViewCell {

  @IBOutlet weak var commitMessageLabel: UILabel!
  @IBOutlet weak var commitDateLabel: UILabel!
  let dateFormatter = DateFormatter()

  func configure(with commit: Commit) {
    commitMessageLabel.text = commit.commit.message

    dateFormatter.dateFormat = "d MMM"
    commitDateLabel.text = "committed on \(dateFormatter.string(from: commit.commit.author.date))"
  }
}
