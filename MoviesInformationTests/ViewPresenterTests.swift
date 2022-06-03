//
//  ViewPresenterTests.swift
//  MoviesInformationTests
//
//  Created by Juan Harrington on 25/05/22.
//

import XCTest
@testable import MoviesInformation


class ViewPresenterTests: XCTestCase {

    var sut: ViewPresenter!
    
    var fetchData: FetchDataMock!
    var storage: StorageMock!
    var view: MockView!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //dependences intantiation.
        fetchData = FetchDataMock()
        storage = StorageMock()
        view = MockView()
        
        //Sut initialization
        sut = ViewPresenter(fetchData: fetchData, storage: storage)
        sut.view = view
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testdisplayMovies() throws {
        //given
        let movieViewModel = MovieViewModel(imageUrlPath: "",
                                            backdropImagesUrlPath: "",
                                            title: "si",
                                            description: "")
        
        let givenStorageMovies:[MovieViewModel] = [movieViewModel]
        storage.viewModels = givenStorageMovies

        //when
        sut.viewDidLoadPresenterFunction()
        
        //then
        XCTAssertEqual(fetchData.recivedUrl,
                       URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=2e95638bfe81862d6fe6622fe5dcc18a"))
        
        
//        XCTAssertEqual(view.recivedMoviesArray,
//                       expectedMovieViewModels)
        
        XCTAssertEqual(view.recivedMoviesArray?.count, 1)
        XCTAssertEqual(view.recivedMoviesArray?.first?.title, "si")
        XCTAssertNil(view.recivedAlert)
    }
    func testEmptyArray_FetchDataSucces_DisplayEmptyArrayAlert() throws {
        //given
        sut.viewDidLoadPresenterFunction()
    
        //when
        fetchData.recivedCompetion?(.success([]))
        
        //then
        XCTAssertEqual(view.recivedAlert, "empty array")
    }
    

    func testDataFailureCase() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
