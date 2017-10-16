//
//  Repository.swift
//  SquareRepos
//
//  Created by Alexander Spirichev on 14/10/2017.
//  Copyright © 2017 Alexander Spirichev. All rights reserved.
//

import Foundation

struct RepositoryContainer {
  var repositories: [Repository]?
  var pagination: Pagination?
}

struct Repository: Decodable {
  let name: String
  let forksCount: Int
  let starsCount: Int
  let description: String?

  enum RepositoryKeys: String, CodingKey {
    case name
    case forksCount = "forks"
    case starsCount = "stargazers_count"
    case description
  }

  init(name: String, forksCount: Int, starsCount: Int, description: String?) {
    self.name = name
    self.forksCount = forksCount
    self.starsCount = starsCount
    self.description = description
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: RepositoryKeys.self)
    let name = try container.decode(String.self, forKey: .name)
    let forksCount = try container.decode(Int.self, forKey: .forksCount)
    let starsCount = try container.decode(Int.self, forKey: .starsCount)
    let description = try container.decode(String?.self, forKey: .description)

    self.init(name: name, forksCount: forksCount, starsCount: starsCount, description: description)
  }
}
