//
//  Pagination.swift
//  SquareRepos
//
//  Created by Alexander Spirichev on 15/10/2017.
//  Copyright © 2017 Alexander Spirichev. All rights reserved.
//

import Foundation

class Pagination {

  var links =  [String: String]()

  init?(_ response: HTTPURLResponse) {
    guard let linksHeader = response.allHeaderFields["Link"] as? String else { return }
    links = linksHeader
      .components(separatedBy: ",")
      .reduce([:]) { result, element in
        var result = result
        let parts = element.trimmingCharacters(in: .whitespaces).components(separatedBy: ";")

        let wrappedUrl = parts[0]
        let start = wrappedUrl.index(wrappedUrl.startIndex, offsetBy: 1)
        let end = wrappedUrl.index(wrappedUrl.endIndex, offsetBy: -1)
        let url = wrappedUrl[start..<end]
        let rel = parts[1].components(separatedBy: "\"")[1]

        result[rel] = String(url)
        return result
    }
  }

  lazy var next: String? = {
    return self.links["next"]
  }()

  lazy var prev: String? = {
    return self.links["prev"]
  }()
}
