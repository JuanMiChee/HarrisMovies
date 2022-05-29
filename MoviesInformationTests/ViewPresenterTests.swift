//
//  ViewPresenterTests.swift
//  MoviesInformationTests
//
//  Created by Juan Harrington on 25/05/22.
//

import XCTest
@testable import MoviesInformation


class ViewPresenterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let fetchData = FetchDataMock()
        let storage = StorageMock()
        let view = MockView()
        let expectedMovieViewModels = [MovieViewModel]()

        let sut = ViewPresenter(fetchData: fetchData, storage: storage)
        sut.view = view
        sut.viewDidLoadPresenterFunction()
        XCTAssertEqual(fetchData.recivedUrl,
                       URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=2e95638bfe81862d6fe6622fe5dcc18a"))
        
        XCTAssertEqual(view.recivedMoviesArray,
                       expectedMovieViewModels)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
