//
//  ViewController.swift
//  MoviesInformation
//
//  Created by Juan Harrington on 18/04/22.
//

import UIKit
import Longinus



class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private lazy var presenter: Presenter = {
        let presenter = ViewPresenter()
        presenter.view = self
        return presenter
    }()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorActive: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorActive.startAnimating()
        presenter.viewDidLoadPresenterFunction()
    }
    
    func showActionSheet(errorMessage: String){
        let alert = UIAlertController(title: "title", message: errorMessage, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: {action in
            print("c piso el cancel padre")
        }))
        DispatchQueue.main.async{
            self.present(alert, animated: true)
        }
    }
    
    var moviesArray = [MovieViewModel]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DataCollectionViewCell
        let viewModel = moviesArray[indexPath.row]
        let posterPath = viewModel.imageUrlPath
        
        let posterImagesUrl = URL(string: "https://image.tmdb.org/t/p/w200//\(posterPath)?api_key=2e95638bfe81862d6fe6622fe5dcc18a")
        cell.ImageView.lg.setImage(with: posterImagesUrl)
        
        cell.DataLabel.text = viewModel.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieViewModel = moviesArray[indexPath.row]
        
        if let viewController = storyboard?.instantiateViewController(identifier: "ViewControllerPageTwo") as? ViewControllerPageTwo {
            viewController.movie = movieViewModel
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension ViewController: View{
    func alertData(result: String) {
        showActionSheet(errorMessage: result )
    }
    
    func display(result:[MovieViewModel]) {
        moviesArray = result
        activityIndicatorActive.stopAnimating()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            
        }
    }
}
