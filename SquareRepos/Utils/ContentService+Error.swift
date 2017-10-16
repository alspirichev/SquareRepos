//
//  ContentService+Error.swift
//  SquareRepos
//
//  Created by Alexander Spirichev on 15/10/2017.
//  Copyright © 2017 Alexander Spirichev. All rights reserved.
//

import Foundation

extension ContentService {

  func isResponseValid(with data: Data?, _ response: URLResponse?, _ error: Error?) -> Error? {
    guard error == nil else {
      if let connectionError = error as? URLError {
        if connectionError.code == URLError.Code.notConnectedToInternet {
          return RequestError.NoInternetConnection(title: NotConnectedToInternet.title, message: NotConnectedToInternet.message)
        } else {
          return RequestError.RequestFaild(title: RequestFailed.title, message: RequestFailed.message)
        }
      }
      return RequestError.UnknownError(title: UnknownError.title, message: UnknownError.message)
    }

    guard (response as! HTTPURLResponse).statusCode == 200 else {
      return RequestError.InvalidURL(title: IncorrectURL.title, message: IncorrectURL.message)
    }

    guard let _ = data else {
      return RequestError.UnknownError(title: RequestFailed.title, message: RequestFailed.message)
    }

    return nil
  }
}
