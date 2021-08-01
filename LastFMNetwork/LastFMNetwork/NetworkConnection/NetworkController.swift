//
//  NetworkController.swift
//  LastFM
//
//  Created by Shinto Joseph on 30/07/2021.
//

import Combine
import Foundation

public protocol NetworkControllerProtocol: AnyObject {
    func get<T>(request: URLRequest) -> AnyPublisher<T, Error> where T: Decodable
}

public enum APIError: Error, LocalizedError {
    case unknown, unAuthorized, apiError(reason: String), noNetwork
    
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .unAuthorized:
            return "Unauthorized or expired access token"
        case .noNetwork:
            return "No Network Connection, Please check your internet"
        case .apiError(let reason):
            return reason
        }
    }
}

public class NetworkController: BaseNetworkConnection, NetworkControllerProtocol {
    
    var session: URLSession
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    public func get<T: Decodable>(request: URLRequest) -> AnyPublisher<T, Error> {
        
        if self.networkAvailable() {
            
            return URLSession.DataTaskPublisher(request: request, session: session)
                .tryMap { response in
                    
                    guard let httpResponse = response.response as? HTTPURLResponse else {
                        throw APIError.unknown
                    }
                    
                    if 200..<300 ~= httpResponse.statusCode {
                        return response.data
                    } else if 400..<417 ~= httpResponse.statusCode {
                        throw APIError.unAuthorized
                    }
                    
                    throw APIError.unknown
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError { error in
                    print(#function, error)
                    if let error = error as? APIError {
                        return error
                    } else {
                        return APIError.apiError(reason: error.localizedDescription)
                    }
                }
                .eraseToAnyPublisher()
        } else {
            return Fail(error: APIError.noNetwork).eraseToAnyPublisher()
        }
    }
}
