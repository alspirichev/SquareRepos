//
//  CommitsViewController.swift
//  SquareRepos
//
//  Created by Alexander Spirichev on 14/10/2017.
//  Copyright © 2017 Alexander Spirichev. All rights reserved.
//

import UIKit

class CommitsViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var tableViewFooter: InfiniteScrollTableFooterView!
  
  var reposName: String!
  private var commitsContainer = CommitContainer()
  private lazy var contentService: ContentServiceProtocol = ContentService()

  fileprivate var loading = false {
    didSet {
      tableViewFooter.isHidden = !loading
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupData()
    loadCommits(by: nil)
  }

  // MARK: Actions

  private func setupData() {
    title = "Commits"
    tableViewFooter.isHidden = true
    tableView.rowHeight = UITableViewAutomaticDimension
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let currentOffset = scrollView.contentOffset.y
    let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

    if (maximumOffset - currentOffset) <= 60, let _ = commitsContainer.pagination?.next {
      loadCommits(by: commitsContainer.pagination?.next)
    }
  }

  private func loadCommits(by url: String?) {
    if !loading {
      loading = true

      contentService.getCommitsForRepos(reposName, by: url, { commitsContainer, error in
        guard error == nil else {
          self.showAlert(with: error!)
          DispatchQueue.main.async {
            self.loading = false
          }
          return
        }

        guard let _ = commitsContainer else {
          self.showAlert(with: RequestError.RequestFaild(title: RequestFailed.title, message: RequestFailed.message))
          DispatchQueue.main.async {
            self.loading = false
          }
          return
        }

        if let _ = self.commitsContainer.commits, let _ = commitsContainer?.commits {
          self.commitsContainer.commits! += commitsContainer!.commits!
        } else {
          self.commitsContainer.commits = commitsContainer?.commits
        }

        self.commitsContainer.pagination = commitsContainer!.pagination

        DispatchQueue.main.async {
          self.loading = false
          self.tableView.reloadData()
        }
      })
    }
  }

}

// MARK: UITableViewDataSource
extension CommitsViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return commitsContainer.commits?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.commitTableViewCellIdentifier, for: indexPath) as! CommitTableViewCell
    cell.configure(with: commitsContainer.commits![indexPath.row])
    return cell
  }
}

// MARK: UITableViewDelegate
extension CommitsViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
