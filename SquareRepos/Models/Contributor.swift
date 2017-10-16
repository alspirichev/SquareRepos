//
//  Contributor.swift
//  SquareRepos
//
//  Created by Alexander Spirichev on 14/10/2017.
//  Copyright © 2017 Alexander Spirichev. All rights reserved.
//

import Foundation

struct Contributor: Decodable {
  let login: String
  let type: String
  let avatarURL: URL

  init(login: String, type: String, avatarURL: URL) {
    self.login = login
    self.type = type
    self.avatarURL = avatarURL
  }

  enum ContributorKeys: String, CodingKey {
    case login, type, avatarURL = "avatar_url"
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: ContributorKeys.self)
    let login = try container.decode(String.self, forKey: .login)
    let type = try container.decode(String.self, forKey: .type)
    let avatarURL = try container.decode(URL.self, forKey: .avatarURL)
    self.init(login: login, type: type, avatarURL: avatarURL)
  }
}
