//
//  AlbumListViewControllerTests.swift
//  LastFM
//
//  Created by Shinto Joseph on 01/08/2021.
//

import XCTest
@testable import LastFM

class AlbumListViewControllerTests: XCTestCase {

    // MARK: - Subject under test

    var sut: AlbumListViewController!
    var interactor: AlbumListBusinessLogicSpy!
    var router: AlbumListRouterSpy!
    var window: UIWindow!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupAlbumListViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: - Test setup

    func setupAlbumListViewController() {
        sut = AlbumListViewController()  // replace with proper instantiation
        interactor = AlbumListBusinessLogicSpy()
        router = AlbumListRouterSpy()
        sut.interactor = interactor
        sut.router = router
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: - Test doubles

    class AlbumListBusinessLogicSpy: AlbumListBusinessLogic {

        var processCalled = false

        func fetch(query: String) {
            processCalled = true
        }
    }

    class AlbumListRouterSpy: AlbumListDataPassing, AlbumListRoutingLogic {
        
        var routeCalled = false
        
        func routeToNext(item: AlbumViewModel) {
            routeCalled = true
        }
        

        let dataStore: AlbumListDataStore? = nil
    }

    // MARK: - Tests

    func testShouldDoSomethingWhenViewIsLoaded() {
        // Given
        //...

        // When
        loadView()

        // Then
        XCTAssertTrue(interactor.processCalled, "viewDidLoad() should ask the interactor to do something")
    }

    func testDisplaySomething() {
        // Given
        let viewModel = Album.testObjects.map { item in
            AlbumViewModel(album: item)
        }

        // When
        loadView()
        sut.display(viewModel: viewModel)

        // Then
        //XCTAssertEqual(sut.nameTextField.text, "", "display(viewModel:) should update the name text field")
    }
}
