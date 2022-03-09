//
//  NetworkError.swift
//  Kick-Off
//
//  Created by Burak Çokyıldırım on 5.03.2022.
//

import Foundation

enum NetworkError: Error {
    case reachabilityError
    case parseError
    case internalServerError
    case badRequestError

    var localizedDescription: String {
        switch self {
        case .reachabilityError:
            return "Please, check your internet connection."
        default:
            return "Unexpected error."
        }
    }
}
