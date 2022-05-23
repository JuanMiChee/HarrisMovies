//  Presenter.swift
//  MoviesInformation
//
//  Created by Juan Harrington on 18/04/22.
//

import Foundation
import UIKit

class ViewPresenter: Presenter {
    
    let apiKey = "2e95638bfe81862d6fe6622fe5dcc18a"
    let baseDataUrl = "https://api.themoviedb.org/3/movie/"
    
    weak var view: View?
    let parsedUrl = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=2e95638bfe81862d6fe6622fe5dcc18a")
    
    func viewDidLoadPresenterFunction() {
        fetchMoviesFromCoreData()
        fetchMoviesFromServer(url: parsedUrl!)
        
    }
    
    private func fetchMoviesFromServer(url:URL) {
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                if let error = error {
                    print("Error en la operación \(error)")
                    DispatchQueue.main.async {
                        self.view?.alertData(result: "Error has ocurred = not found" )
                    }
                }
                return
            }
            
            if let decodedData = try? JSONDecoder().decode(PopularMoviesServersResponse.self, from: data) {
                DispatchQueue.main.async {
                    let viewModels: [MovieViewModel] = decodedData.results.map { (movieJSON) -> MovieViewModel in
                        
                        return MovieViewModel(imageUrlPath: String(movieJSON.poster_path),
                                              backdropImagesUrlPath: String(movieJSON.backdrop_path),
                                              title: movieJSON.original_title,
                                              description: movieJSON.overview)
                        
                    }
                    
                    decodedData.results.forEach { (movieJSON) in
                        
                        let newMovie = Movie(context: self.context)
                        newMovie.movieName = movieJSON.original_title
                    }
                    try? self.context.save()
                    
                    //print(viewModels)
                    if viewModels.isEmpty {
                        self.view?.alertData(result: "movies not found...")
                    }else {
                        self.view?.display(result: viewModels)
                    }
                }
            }
            if response.statusCode == 200 {
            } else {
                print("Error \(response.statusCode)")
            }
        }.resume()
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    func fetchMoviesFromCoreData(){
        do{
//            let storageMovies: [Movie] = try context.fetch(Movie.fetchRequest())
//            let mappedStorageMovies: [MovieViewModel] = storageMovies.map { (movie) -> MovieViewModel in
//                return MovieViewModel(imageUrlPath: <#T##String#>, backdropImagesUrlPath: <#T##String#>, title: <#T##String#>, description: <#T##String#>)
//            }
            //collectionView.reloadData()
        }
        catch{
            print("error")
        }
    }
}

