//
//  MockNetworkService.swift
//  Kick-OffTests
//
//  Created by Burak Çokyıldırım on 9.03.2022.
//

import Foundation
@testable import Kick_Off
@testable import Alamofire

class MockNetworkService: NetworkServiceProtocol {
    var currentError: NetworkError?

    func executeRequest<T: Decodable>(method: HTTPMethod, url: URLConvertible, parameters: [String : Any]?, headers: [String : String]?, completion: @escaping (Result<T, NetworkError>) -> Void) {
        if let currentError = currentError {
            completion(.failure(currentError))
            return
        }

        if T.self == LoginModel.self,
            let model = MockedData.login(of: T.self) {
            completion(.success(model))
        }

        completion(.failure(.badRequestError))
    }
}
