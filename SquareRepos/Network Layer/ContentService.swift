//
//  ContentService.swift
//  SquareRepos
//
//  Created by Alexander Spirichev on 14/10/2017.
//  Copyright © 2017 Alexander Spirichev. All rights reserved.
//

import Foundation

protocol ContentServiceProtocol {
  func getSquareRepos(by url: String?, _ completion: @escaping (RepositoryContainer?, Error?) -> Void)
  func getCommitsForRepos(_ reposName: String, by url: String?, _ completion: @escaping (CommitContainer?, Error?) -> Void)
  func getContributorsForRepos(_ reposName: String, _ completion: @escaping ([Contributor]?, Error?) -> Void)
}

final class ContentService: ContentServiceProtocol {

  func getSquareRepos(by url: String?, _ completion: @escaping (RepositoryContainer?, Error?) -> Void) {
    guard let url = URL(string: url ?? API.squareRepositories) else {
      return completion(nil, RequestError.InvalidURL(title: IncorrectURL.title, message: IncorrectURL.message))
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      let requestError = self.isResponseValid(with: data, response, error)
      guard requestError == nil else {
        return completion(nil, requestError)
      }

      let repository: [Repository]? = try! JSONDecoder().decode([Repository]?.self, from: data!)
      let pagination = Pagination(response as! HTTPURLResponse)
      let repositoryContainer = RepositoryContainer(repositories: repository, pagination: pagination)

      return completion(repositoryContainer, nil)
    }.resume()
  }

  func getCommitsForRepos(_ reposName: String, by url: String?, _ completion: @escaping (CommitContainer?, Error?) -> Void) {
    guard let url = URL(string: url ?? API.repositories + reposName + API.commit) else {
      return completion(nil, RequestError.InvalidURL(title: IncorrectURL.title, message: IncorrectURL.message))
    }

    URLSession.shared.dataTask(with: url) { data, response, error in
      let requestError = self.isResponseValid(with: data, response, error)
      guard requestError == nil else {
        return completion(nil, requestError)
      }
      
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .iso8601
      let commits: [Commit] = try! decoder.decode([Commit].self, from: data!)
      let pagination = Pagination(response as! HTTPURLResponse)
      let commitContainer = CommitContainer(commits: commits, pagination: pagination)

      return completion(commitContainer, nil)
    }.resume()
  }

  func getContributorsForRepos(_ reposName: String, _ completion: @escaping ([Contributor]?, Error?) -> Void) {
    guard let url = URL(string: API.repositories + reposName + API.contributors) else {
      return completion(nil, RequestError.InvalidURL(title: IncorrectURL.title, message: IncorrectURL.message))
    }

    URLSession.shared.dataTask(with: url) { data, response, error in
      let requestError = self.isResponseValid(with: data, response, error)
      guard requestError == nil else {
        return completion(nil, requestError)
      }

      let contributors: [Contributor] = try! JSONDecoder().decode([Contributor].self, from: data!)
      return completion(contributors, nil)
      }.resume()
  }
}
