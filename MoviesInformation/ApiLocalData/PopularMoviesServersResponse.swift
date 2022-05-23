//
//  PopularMoviesJson.swift
//  MoviesInformation
//
//  Created by Juan Harrington on 20/04/22.
//

import Foundation

struct PopularMoviesServersResponse: Decodable {
    let page: Int
    let results:[MovieJSON]
}
