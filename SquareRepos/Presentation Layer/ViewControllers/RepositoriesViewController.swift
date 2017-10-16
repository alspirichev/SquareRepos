//
//  ReposViewController.swift
//  SquareRepos
//
//  Created by Alexander Spirichev on 14/10/2017.
//  Copyright © 2017 Alexander Spirichev. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var tableViewFooter: InfiniteScrollTableFooterView!
  
  private var repositoryContainer = RepositoryContainer()
  private lazy var contentService: ContentServiceProtocol = ContentService()

  fileprivate var loading = false {
    didSet {
      tableViewFooter.isHidden = !loading
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    tableViewFooter.isHidden = true
    tableView.rowHeight = UITableViewAutomaticDimension
    loadSquareRepositories(by: nil)
  }

  // MARK: Actions

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let currentOffset = scrollView.contentOffset.y
    let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

    if (maximumOffset - currentOffset) <= 60, let _ = repositoryContainer.pagination?.next {
      loadSquareRepositories(by: repositoryContainer.pagination?.next)
    }
  }

  func loadSquareRepositories(by url: String?) {
    if !loading {
      loading = true

      contentService.getSquareRepos(by: url) { [unowned self] repositoryContainer, error in
        guard error == nil else {
          self.showAlert(with: error!)
          DispatchQueue.main.async {
            self.loading = false
          }
          return
        }

        guard let _ = repositoryContainer else {
          self.showAlert(with: RequestError.RequestFaild(title: RequestFailed.title, message: RequestFailed.message))
          DispatchQueue.main.async {
            self.loading = false
          }
          return
        }

        if let _ = self.repositoryContainer.repositories, let _ = repositoryContainer?.repositories {
          self.repositoryContainer.repositories! += repositoryContainer!.repositories!
        } else {
          self.repositoryContainer.repositories = repositoryContainer?.repositories
        }

        self.repositoryContainer.pagination = repositoryContainer!.pagination

        DispatchQueue.main.async {
          self.loading = false
          self.tableView.reloadData()
        }
      }
    }
  }
}

extension RepositoriesViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier! {
    case SegueIdentifiers.showRepositoryDescriptions:
      let repositoryDescriptionViewController = segue.destination as! RepositoryDescriptionViewController
      repositoryDescriptionViewController.repository = sender as! Repository
    default: break
    }
  }
}

// MARK: UITableViewDataSource
extension RepositoriesViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repositoryContainer.repositories?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.repositoryTableViewCellIdentifier, for: indexPath) as! RepositoryTableViewCell
    cell.configure(withRepo: repositoryContainer.repositories![indexPath.row])
    return cell
  }
}

// MARK: UITableViewDelegate
extension RepositoriesViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    performSegue(withIdentifier: SegueIdentifiers.showRepositoryDescriptions, sender: repositoryContainer.repositories?[indexPath.row])
  }
}
