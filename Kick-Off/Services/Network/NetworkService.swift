//
//  NetworkService.swift
//  Kick-Off
//
//  Created by Burak Çokyıldırım on 5.03.2022.
//

import Foundation
import Alamofire
import Kingfisher

protocol NetworkServiceProtocol: AnyObject {
    func executeRequest<T: Decodable>(method: HTTPMethod, url: URLConvertible, parameters: [String: Any]?, headers: [String: String]?, completion: @escaping (Result<T, NetworkError>) -> Void)
}

extension NetworkServiceProtocol {
    func executeRequest<T: Decodable>(method: HTTPMethod, url: URLConvertible, parameters: [String: Any]? = nil, headers: [String: String]? = nil, completion: @escaping (Result<T, NetworkError>) -> Void) {
        executeRequest(method: method, url: url, parameters: parameters, headers: headers, completion: completion)
    }
}

class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()

    var reachabilityStatus: NetworkReachabilityManager.NetworkReachabilityStatus = .unknown
    var imageDownloader: ImageDownloader = {
       var imageDownloader = ImageDownloader.default
        imageDownloader.trustedHosts = Set(["service.scoutium.com"])

        return imageDownloader
    }()

    static private let interceptor: RequestInterceptor = {
        let adapterAndRetrier = NetworkRequestAdapter.shared
        return Interceptor(adapter: adapterAndRetrier, retrier: adapterAndRetrier)
    }()

    private let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        return Session(configuration: configuration, interceptor: NetworkService.interceptor)
    }()

    private init() {
        KingfisherManager.shared.downloader = imageDownloader
    }

    // MARK: - Methods
    func executeRequest<T: Decodable>(method: HTTPMethod, url: URLConvertible, parameters: [String: Any]? = nil, headers: [String: String]? = nil, completion: @escaping (Result<T, NetworkError>) -> Void) {

        if !isInternetAvailable() {
            print("Response Failure Reachability: \n")
            completion(.failure(.reachabilityError))
            return
        }

        var httpHeaders: HTTPHeaders?
        if let headerParameters = addHeaders(headers: headers) {
            print("Header Parameters: \(String(describing: headerParameters))\n")
            httpHeaders = HTTPHeaders(headerParameters)
        }

        DispatchQueue.global().async { [weak self] in
            self?.session.request(
                url,
                method: method,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: httpHeaders
            ).responseDecodable(of: T.self) { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        print(error)
                        completion(.failure(.parseError))
                    }
                }
            }
        }
    }

    // MARK: - Utils
    func isInternetAvailable() -> Bool {
        switch reachabilityStatus {
        case .notReachable:
            return false
        case .unknown:
            return true
        case .reachable(.ethernetOrWiFi):
            return true
        case .reachable(.cellular):
            return true
        }
    }

    func addHeaders(headers: [String: String]? = nil) -> [String: String]? {
        var headerParameters: [String: String]?

        if let defaultHeaders = NetworkService.defaultHeaders() {
            headerParameters = defaultHeaders
        }

        if let parameters = headers {
            if headerParameters == nil {
                headerParameters = [String: String]()
            }
            headerParameters?.merge(parameters, uniquingKeysWith: { $1 })
        }
        return headerParameters
    }

    static func defaultHeaders() -> [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
