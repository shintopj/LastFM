//
//  AlbumListInteractorTests.swift
//  LastFM
//
//  Created by Shinto Joseph on 01/08/2021.
//

@testable import LastFM
import XCTest

class AlbumListInteractorTests: XCTestCase {

    // MARK: - Subject under test

    var sut: AlbumListInteractor!
    var presenter: AlbumListPresentationLogicSpy!
    var worker: AlbumListWorkerProtocolMock!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        setupAlbumListInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Test setup

    func setupAlbumListInteractor() {
        presenter = AlbumListPresentationLogicSpy()
        worker = AlbumListWorkerProtocolMock()
        sut = AlbumListInteractor(presenter: presenter, worker: worker/*, name: ""*/)
    }

    // MARK: - Test doubles

    class AlbumListPresentationLogicSpy: AlbumListPresentationLogic {

        var presentCalled = false
        var presentErrorCalled = false

        func present(albums: [Album]) {
            presentCalled = true
        }

        func present(error: Error) {
            presentErrorCalled = true
        }
    }

    class AlbumListWorkerProtocolMock: AlbumListWorkerProtocol {
        
        func search(query: String, completion: @escaping (Result<AlbumSearch, Error>) -> Void) {
            
            completion(.failure(NSError(domain: "search error", code: 0, userInfo: [NSLocalizedDescriptionKey: "unable to search"])))
            
        }
    }

    // MARK: - Tests

    func testDoSomething() {
        // Given

        // When
        
        sut.fetch(query: "helllooo")
        
        presenter.present(albums: Album.testObjects)

        // Then
        XCTAssertTrue(presenter.presentCalled, "process(request:) should ask the presenter to format the result")
    }
}
