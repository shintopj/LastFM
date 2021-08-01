//
//  AlbumListWorkerTests.swift
//  LastFM
//
//  Created by Shinto Joseph on 01/08/2021.
//

@testable import LastFM
import XCTest

class AlbumListWorkerTests: XCTestCase {

    // MARK: - Subject under test

    var sut: AlbumListWorker!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        setupAlbumListWorker()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Test setup

    func setupAlbumListWorker() {
        sut = AlbumListWorker()
    }

    // MARK: - Test doubles

    // MARK: - Tests

    func testFetch() {
        // Given

        // When

        // Then
    }
}
