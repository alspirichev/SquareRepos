//
//  ContributorsViewController.swift
//  SquareRepos
//
//  Created by Alexander Spirichev on 14/10/2017.
//  Copyright © 2017 Alexander Spirichev. All rights reserved.
//

import UIKit

class ContributorsViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!

  var reposName: String!
  private var contributors = [Contributor]()
  private lazy var contentService: ContentServiceProtocol = ContentService()

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Contributors"
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.tableFooterView = UIView(frame: .zero)
    loadContributors()
  }

  // MARK: Actions

  func loadContributors() {
    contentService.getContributorsForRepos(reposName) { contributors, error in
      guard error == nil else {
        self.showAlert(with: error!)
        return
      }

      guard let contributors = contributors else {
        self.showAlert(with: RequestError.RequestFaild(title: RequestFailed.title, message: RequestFailed.message))
        return
      }

      self.contributors = contributors

      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
}

// MARK: UITableViewDataSource
extension ContributorsViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contributors.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.contributorTableViewCellIdentifier, for: indexPath) as! ContributorTableViewCell
    cell.configureWith(contributor: contributors[indexPath.row])
    return cell
  }
}

// MARK: UITableViewDelegate
extension ContributorsViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

