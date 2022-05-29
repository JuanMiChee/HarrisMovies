//
//  FetchDataMock.swift
//  MoviesInformationTests
//
//  Created by Juan Harrington on 25/05/22.
//

import Foundation
@testable import MoviesInformation

class FetchDataMock: FetchDataProtocol {
    
    var recivedUrl: URL?
    var recivedCompetion: ((Result<[MovieViewModel], FetchError>) -> Void)?
    
    func fetchMoviesFromServer(url: URL, completion: @escaping (Result<[MovieViewModel], FetchError>) -> Void) {
        recivedUrl = url
        recivedCompetion = completion
    }
}
