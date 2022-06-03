//
//  FetchData.swift
//  MoviesInformation
//
//  Created by Juan Harrington on 22/05/22.
//

import Foundation
import UIKit


enum FetchError: Error {
    case networkError(errormessage: String)
}

protocol FetchDataProtocol{
    func fetchMoviesFromServer(url: URL, completion: @escaping (Result<[MovieViewModel], FetchError>) -> Void)
}


class FetchData: FetchDataProtocol{
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func fetchMoviesFromServer(url: URL, completion: @escaping (Result<[MovieViewModel], FetchError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                if let error = error {
                    print("Error en la operación \(error)")
                    DispatchQueue.main.async {
                        completion(.failure(.networkError(errormessage: error.localizedDescription)))
                    }
                    
                    return
                }
                return
            }
            
            if let decodedData = try? JSONDecoder().decode(PopularMoviesServersResponse.self, from: data) {
                
                    let viewModels: [MovieViewModel] = decodedData.results.map { (movieJSON) -> MovieViewModel in
                        
                        return MovieViewModel(imageUrlPath: String(movieJSON.poster_path),
                                              backdropImagesUrlPath: String(movieJSON.backdrop_path),
                                              title: movieJSON.original_title,
                                              description: movieJSON.overview)
                        
                    }
                    
                    decodedData.results.forEach { (movieJSON) in
                        
                        let newMovie = Movie(context: self.context)
                        newMovie.movieName = movieJSON.original_title
                        newMovie.backDropImageUrlPath = movieJSON.backdrop_path
                        newMovie.descriptionInfo = movieJSON.overview
                        newMovie.imageUrlPath = movieJSON.poster_path
                    }
                    try? self.context.save()
        
                DispatchQueue.main.async {
                    completion(.success(viewModels))
                }
                
            }
            if response.statusCode == 200 {
            } else {
                print("Error \(response.statusCode)")
            }
        }.resume()
    }
}
