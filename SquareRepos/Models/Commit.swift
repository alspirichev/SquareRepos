//
//  Commit.swift
//  SquareRepos
//
//  Created by Alexander Spirichev on 14/10/2017.
//  Copyright © 2017 Alexander Spirichev. All rights reserved.
//

import Foundation

struct CommitContainer {
  var commits: [Commit]?
  var pagination: Pagination?
}

struct Commit: Decodable {
  let commit: CommitDescription
}

struct CommitDescription: Decodable {
  let message: String
  let author: Author
}

struct Author: Decodable {
  let date: Date
}
