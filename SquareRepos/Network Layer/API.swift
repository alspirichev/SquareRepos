//
//  API.swift
//  SquareRepos
//
//  Created by Alexander Spirichev on 13/10/2017.
//  Copyright © 2017 Alexander Spirichev. All rights reserved.
//

import Foundation

struct API {
  private static let baseURL = "https://api.github.com"

  static let squareRepositories = baseURL + "/orgs/square/repos"
  static let repositories = baseURL + "/repos/square/"
  static let commit = "/commits"
  static let contributors = "/contributors"
}
