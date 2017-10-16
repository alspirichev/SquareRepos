//
//  Errors.swift
//  SquareRepos
//
//  Created by Alexander Spirichev on 14/10/2017.
//  Copyright © 2017 Alexander Spirichev. All rights reserved.
//

import Foundation

extension Error {

  var descriptionValue: (title: String, message: String) {
    var result = (title: UnknownError.title, message: UnknownError.message)

    switch self {
    case let error as URLError where error.code == URLError.Code.notConnectedToInternet:
      result = (title: NotConnectedToInternet.title, message: NotConnectedToInternet.message)
    case let error as  RequestError:
      result = error.descriptionValue
    default:
      result = (title: UnknownError.title, message: self.localizedDescription)
    }

    return result
  }
}

enum RequestError: Error {
  case InvalidURL(title: String, message: String)
  case RequestFaild(title: String, message: String)
  case UnknownError(title: String, message: String)
  case NoInternetConnection(title: String, message: String)

  var descriptionValue: (title: String, message: String) {
    switch self {
    case let .InvalidURL(title, message):
      return (title, message)
    case let .RequestFaild(title, message):
      return (title, message)
    case let .UnknownError(title, message):
      return (title, message)
    case let .NoInternetConnection(title, message):
      return (title, message)
    }
  }
}

struct UnknownError {
  static let title = "Operation failed"
  static let message = "Something went wrong, please, try again later"
}

struct NotConnectedToInternet {
  static let title = "No network connection"
  static let message = "The application require internet connection"
}

struct IncorrectURL {
  static let title = "Incorrect URL"
  static let message = "URL address is incorrect!"
}

struct RequestFailed {
  static let title = "Request failed"
  static let message = "Request data is wrong"
}
