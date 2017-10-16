//
//  RepositoryDescriptionTableViewController.swift
//  SquareRepos
//
//  Created by Alexander Spirichev on 14/10/2017.
//  Copyright © 2017 Alexander Spirichev. All rights reserved.
//

import UIKit

class RepositoryDescriptionViewController: UIViewController {
  
  @IBOutlet weak var descriptionReposLabel: UILabel!
  var repository: Repository!

  override func viewDidLoad() {
    super.viewDidLoad()

    title = repository.name
    descriptionReposLabel.text = repository.description
  }
}

extension RepositoryDescriptionViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier! {
    case SegueIdentifiers.showCommitsList:
      let commitsViewController = segue.destination as! CommitsViewController
      commitsViewController.reposName = repository.name
    case SegueIdentifiers.showContributorsList:
      let contributorsViewController = segue.destination as! ContributorsViewController
      contributorsViewController.reposName = repository.name
    default: break
    }
  }
}
