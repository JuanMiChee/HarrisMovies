//
//  CoreDataStorageMock.swift
//  MoviesInformationTests
//
//  Created by Juan Harrington on 28/05/22.
//

import Foundation
@testable import MoviesInformation


class StorageMock : Storage{
    
    var viewModels = [MovieViewModel]()
    
    
    func fetchMovies() -> [MovieViewModel] {
        return viewModels
    }
}
