//
//  NetworkRequestAdapter.swift
//  Kick-Off
//
//  Created by Burak Çokyıldırım on 5.03.2022.
//

import Foundation
import Alamofire

class NetworkRequestAdapter: RequestAdapter, RequestRetrier {
    private typealias RefreshCompletion = (_ succeeded: Bool, _ accessToken: String?) -> Void

    private let lock = NSLock()

    private var isRefreshing = false
    private var requestsToRetry: [(RetryResult) -> Void] = []

    var accessToken: String? {
        get {
            UserDefaults.standard.accessToken
        }
        set {
            UserDefaults.standard.accessToken = newValue
        }
    }

    var refreshToken: String? = nil
    static let shared = NetworkRequestAdapter()

    private init() { }

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest

        if let urlString = urlRequest.url?.absoluteString, !urlString.hasSuffix("/oauth/token") {
            if let token = accessToken {
                urlRequest.headers.add(.authorization(bearerToken: token))
            }
        }
        completion(.success(urlRequest))
    }

    // MARK: - RequestRetrier
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        lock.lock()
        defer { lock.unlock() }

        if let response = request.task?.response as? HTTPURLResponse,
           response.statusCode == 401 {
            requestsToRetry.append(completion)

            if isRefreshing == false {
                refreshTokens { [weak self] succeeded, accessToken in
                    guard let self = self else { return }

                    self.lock.lock(); do { self.lock.unlock() }

                    if let accessToken = accessToken {
                        self.accessToken = accessToken
                    }

                    self.requestsToRetry.forEach { $0(succeeded ? .doNotRetry : .retryWithDelay(2.0)) }
                    self.requestsToRetry.removeAll()
                }
            }
        } else {
            completion(.doNotRetry)
        }
    }

    // MARK: - Private - Refresh Tokens
    private func refreshTokens(completion: @escaping RefreshCompletion) {
        guard !isRefreshing else { return }

        isRefreshing = true

        let urlString = NetworkConstans.login + "/renew"
        let refreshToken = UserDefaults.standard.refreshToken ?? ""
        let headers = [
            "Authorization": "Bearer \(refreshToken)"
        ]

        NetworkService.shared.executeRequest(
            method: .get, url: urlString, headers: headers
        ) { [weak self] (result: Result<LoginModel, NetworkError>) in
            guard let self = self else { return }
            if case .success(let model) = result {
                let accessToken = model.accessToken
                completion(true, accessToken)
            } else {
                completion(false, nil)
            }
            self.isRefreshing = false
        }

    }
}
