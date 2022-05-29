//
//  View.swift
//  MoviesInformation
//
//  Created by Juan Harrington on 19/04/22.
//

import Foundation

struct MovieViewModel: Equatable {
    let imageUrlPath: String
    let backdropImagesUrlPath: String
    let title: String
    let description: String
}

protocol View: AnyObject {
    func display(result:[MovieViewModel])
    func alertData(result: String)
}
