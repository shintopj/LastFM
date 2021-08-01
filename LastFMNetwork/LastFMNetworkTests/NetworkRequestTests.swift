//
//  NetworkRequestTests.swift
//  LastFMNetworkTests
//
//  Created by Shinto Joseph on 01/08/2021.
//

@testable import LastFMNetwork
import XCTest

class NetworkRequestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        if let request = getRequest() {
            
            let headerCheck = request.allHTTPHeaderFields?.contains { (key: String, value: String) in
                key == "Content-Type" && value == "application/json"
            }
            
            XCTAssertTrue(headerCheck != nil, "Header should contain Content-Type")
            
            let urlCheck = request.url?.absoluteURL.absoluteString.contains("method=album.search")
            
            XCTAssertTrue((urlCheck != nil), "url should contain method=album.search")
        }
        
    }
    
    private func getRequest() -> URLRequest? {
    
        if let url = URL(string: "https://ws.audioscrobbler.com/2.0/") {
            
            var headers: [String: String] = [:]
            headers["Content-Type"] = "application/json"
            
            var parameters: [String: String] = [:]
            parameters["method"] = "album.search"
            
            let request = NetworkRequest.get(url: url, parameters: parameters, headers: headers)
            
            return request
        }
        
        return nil
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            _ = getRequest()
        }
    }

}
