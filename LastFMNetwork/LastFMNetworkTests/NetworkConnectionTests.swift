//
//  NetworkConnectionTests.swift
//  LastFMNetworkTests
//
//  Created by Shinto Joseph on 31/07/2021.
//

import Combine
@testable import LastFMNetwork
import XCTest

struct Mock: Codable {
    var html: String
}

class NetworkConnectionTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetch() {
        
        if let url = URL(string: "https://lastfm.freetls.fastly.net"), let mockRequest = URLRequest(url: url) {
           
        _ = MockConnection()
            .getResponse(request: mockRequest)
            .sink(
                receiveCompletion: { _ in
                },
                receiveValue: { response in
                    XCTAssertLessThanOrEqual(response.html, "welcome test", "object should load mock data ")
                }
            )
        }
    }
    
    private class MockConnection {
        
        let session: URLSession
        
        init() {
            // this is the URL we expect to call
            let url = URL(string: "https://lastfm.freetls.fastly.net")
            
            // attach that to some fixed data in our protocol handler
            URLProtocolMock.testURLs = [url: Data("{\"html\":\"welcome test\"}".utf8)]
            
            // now set up a configuration to use our mock
            let config = URLSessionConfiguration.ephemeral
            config.protocolClasses = [URLProtocolMock.self]
            
            session = URLSession(configuration: config)
        }
        
        func getResponse(request: URLRequest) -> AnyPublisher<Mock, Error> {
            return NetworkController(session: session)
                .get(request: request)
        }
    }
}
