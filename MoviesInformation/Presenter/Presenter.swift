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
        downloadImage(url: parsedUrl!)
        //downloadImage(url: imagesUrl!)
    }
    
    func downloadImage(url:URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                if let error = error {
                    print("Error en la operación \(error)")
                    self.view?.alertData(result: "Error has ocurred = not found" )
                }
                return
            }
            
            if let decodedData = try? JSONDecoder().decode(PopularMoviesJson.self, from: data){
                DispatchQueue.main.async {
                    let viewModels = decodedData.results.map { (movieJSON) -> MovieViewModel in
                        .init(imageUrlPath: String(movieJSON.poster_path), backdropImagesUrlPath: String(movieJSON.backdrop_path), title: movieJSON.original_title, description: movieJSON.overview)
                    }
                    if viewModels.isEmpty{
                        self.view?.alertData(result: "movies not found...")
                    }else{
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
}

