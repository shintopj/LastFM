//
//  NetworkRequest.swift
//  LastFM
//
//  Created by Shinto Joseph on 30/07/2021.
//

import Foundation

public class NetworkRequest: NSObject {
    
    static func get(url baseURL: URL, headers: [String: String]) -> URLRequest {
        var request = URLRequest(url: baseURL, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: Timeout.medium.rawValue)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        return request
    }
    
    public static func get(url baseURL: URL, parameters: [String: String], headers: [String: String]) -> URLRequest {
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        
        components?.queryItems = parameters.map { key, value -> URLQueryItem in
            return URLQueryItem(name: key, value: value)
        }
        
        guard let url = components?.url else {
            fatalError("baseURL could not be configured.")
        }
        
        return get(url: url, headers: headers)
    }
}
