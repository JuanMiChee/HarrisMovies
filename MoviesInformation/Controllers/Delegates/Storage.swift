//
//  Storage.swift
//  MoviesInformation
//
//  Created by Juan Harrington on 27/05/22.
//

import Foundation
import UIKit


protocol Storage {
    func fetchMovies() -> [MovieViewModel]
}

class CoreDataStorage: Storage {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func fetchMovies() -> [MovieViewModel] {
        do{
            let storageMovies: [Movie] = try context.fetch(Movie.fetchRequest())
            
            let viewModels: [MovieViewModel] = storageMovies.map { (movie) -> MovieViewModel in
                return MovieViewModel(imageUrlPath: String(movie.imageUrlPath),
                                      backdropImagesUrlPath: movie.backDropImageUrlPath,
                                      title: movie.movieName,
                                      description: movie.descriptionInfo) }
            return viewModels
        }
        
        catch{
            print("error")
            return []
        }
    }
}
