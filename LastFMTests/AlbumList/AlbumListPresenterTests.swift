//
//  AlbumListPresenterTests.swift
//  LastFM
//
//  Created by Shinto Joseph on 01/08/2021.
//

@testable import LastFM
import XCTest

class AlbumListPresenterTests: XCTestCase {

    // MARK: - Subject under test

    var sut: AlbumListPresenter!
    var viewController: AlbumListDisplayLogicSpy!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        setupAlbumListPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Test setup

    func setupAlbumListPresenter() {
        viewController = AlbumListDisplayLogicSpy()
        sut = AlbumListPresenter(viewController: viewController)
    }

    // MARK: - Test doubles

    class AlbumListDisplayLogicSpy: AlbumListDisplayLogic {

        var displayCalled = false
        var displayErrorCalled = false

        func display(viewModel: [AlbumViewModel]) {
            displayCalled = true
        }

        func displayError(viewModel: String) {
            displayErrorCalled = true
        }
    }

    // MARK: - Tests

    func testDisplaySuccess() {
       
        let viewModels = Album.testObjects.map { item in
            AlbumViewModel(album: item)
        }
        
        // When
        viewController.display(viewModel: viewModels)

        // Then
        XCTAssertTrue(viewController.displayCalled, "viewController.display(viewModel:) should ask the view controller to display the result")
    }
    
    func testDisplayError() {
        
        // When
        viewController.displayError(viewModel: "unable to retrive search")
        
        // Then
        XCTAssertTrue(viewController.displayErrorCalled, "viewController.displayError(viewModel:) should ask the view controller to display the result")
    }
}
