//
//  ViewController.swift
//  MoviesInformation
//
//  Created by Juan Harrington on 18/04/22.
//

import Longinus


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate{
        
    private lazy var presenter: Presenter = {
        let presenter = ViewPresenter()
        presenter.view = self
        return presenter
    }()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorActive: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorActive.startAnimating()
        presenter.viewDidLoadPresenterFunction()
        
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            filteredArray = moviesArray
        }else{
            print("wirte...")
            filteredArray = moviesArray.filter {
                $0.title.range(of: searchText, options: .caseInsensitive) != nil
            }
        }
        
        collectionView.reloadData()
    }
    
    func showActionSheet(errorMessage: String){
        let alert = UIAlertController(title: "ERROR", message: errorMessage, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: {action in
            //self.showActionSheet(errorMessage: errorMessage)
            self.presenter.viewDidLoadPresenterFunction()
            print("Retry was pressed")
        }))
        self.present(alert, animated: true)
    }
    
    var moviesArray = [MovieViewModel]()
    var filteredArray = [MovieViewModel]()

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DataCollectionViewCell
        let viewModel = filteredArray[indexPath.row]
        //let posterPath = viewModel.imageUrlPath
        cell.DataLabel.text = viewModel.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath){
        let cell = cell as! DataCollectionViewCell
        let viewModel = filteredArray[indexPath.row]
        let posterPath = viewModel.imageUrlPath
        
        let posterImagesUrl = URL(string: "https://image.tmdb.org/t/p/w200//\(posterPath)?api_key=2e95638bfe81862d6fe6622fe5dcc18a")
        cell.ImageView.lg.setImage(with: posterImagesUrl)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieViewModel = filteredArray[indexPath.row]
        
        if let viewController = storyboard?.instantiateViewController(identifier: "ViewControllerPageTwo") as? ViewControllerPageTwo {
            viewController.movie = movieViewModel
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
}

extension ViewController: View{
    func alertData(result: String) {
        showActionSheet(errorMessage: result )
    }
    
    func display(result:[MovieViewModel]) {
        moviesArray = result
        filteredArray = result
        activityIndicatorActive.stopAnimating()
        collectionView.reloadData()
    }
}
