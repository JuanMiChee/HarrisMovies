//
//  ViewController.swift
//  MoviesInformation
//
//  Created by Juan Harrington on 18/04/22.
//

import Longinus
import FirebaseAuth
import CoreData

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate{
    
    private lazy var presenter: Presenter = {
        let presenter = ViewPresenter()
        presenter.view = self
        return presenter
    }()
    
    enum providerType: String {
        case basic
    }
    
    var email : String = ""
    var password: String = ""
    var provider: providerType?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorActive: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorActive.startAnimating()
        presenter.viewDidLoadPresenterFunction()
        navigationItem.setHidesBackButton(true, animated: false)
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.set(provider?.rawValue, forKey: "provider")
        defaults.synchronize()
        
        searchBar.delegate = self
    }
    
    @IBAction func logOutButtonAction(_ sender: Any) {
        
        func logOutSuggestion(){
            let alertController = UIAlertController(title: "Do you want to log out?", message: "You are logging out", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alertController.addAction(UIAlertAction(title: "Accept", style: .default, handler: { (UIAlertAction) in
                do {
                    try Auth.auth().signOut()
                    self.navigationController?.popViewController(animated: true)
                }catch{
                    print("se ha producido un error...")
                }
                let defaults = UserDefaults.standard
                defaults.removeObject(forKey: "Email")
                defaults.removeObject(forKey: "provider")
                defaults.synchronize()
            }))
            self.present(alertController, animated: true, completion: nil)
        }
        logOutSuggestion()
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
        
        if let viewController = storyboard?.instantiateViewController(identifier: "ViewControllerPageTwo") as? MovieDetailViewController {
            viewController.movie = movieViewModel
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
}

extension HomeViewController: View{
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
