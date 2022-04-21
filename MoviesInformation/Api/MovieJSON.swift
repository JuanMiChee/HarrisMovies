//
//  MovieJSON.swift
//  MoviesInformation
//
//  Created by Juan Harrington on 20/04/22.
//

import Foundation

struct MovieJSON: Decodable {
    let poster_path: String
    let adult: Bool
    let original_language: String
    let original_title: String
    let release_date: String
    let overview: String
    let backdrop_path: String
}
