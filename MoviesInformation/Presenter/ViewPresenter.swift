//  Presenter.swift
//  MoviesInformation
//
//  Created by Juan Harrington on 18/04/22.
//

import Foundation
import UIKit

class ViewPresenter: Presenter {
    
    private let apiKey = "2e95638bfe81862d6fe6622fe5dcc18a"
    private let baseDataUrl = "https://api.themoviedb.org/3/movie/"
    
    weak var view: View?
    private let fetchData: FetchDataProtocol
    private let storage: Storage
    
    private let parsedUrl = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=2e95638bfe81862d6fe6622fe5dcc18a")
    
    init(fetchData: FetchDataProtocol, storage: Storage){
        self.fetchData = fetchData
        self.storage = storage
    }
    
    func viewDidLoadPresenterFunction() {
        let viewModels = storage.fetchMovies()
        
        view?.display(result: viewModels)
        fetchData.fetchMoviesFromServer(url: parsedUrl!) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let viewModels):
                    self.view?.display(result: viewModels)
                case .failure(let error):
                    self.view?.alertData(result: error.localizedDescription)
                }
            }
        }
    }
    
   

}

