//
//  ViewMock.swift
//  MoviesInformationTests
//
//  Created by Juan Harrington on 25/05/22.
//

import Foundation
@testable import MoviesInformation


class MockView: View{
    var recivedMoviesArray:[MovieViewModel]?
    var recivedAlert: String?

    func display(result: [MovieViewModel]) {
        recivedMoviesArray = result
    }

    func displayAlert(message: String) {
        recivedAlert = message
    }
}
