//
//  ViewControllerPageTwo.swift
//  MoviesInformation
//
//  Created by Juan Harrington on 21/04/22.
//

import UIKit

class ViewControllerPageTwo: UIViewController {
    
    @IBOutlet weak var desciptionImage: UIImageView!
    @IBOutlet weak var descriptionParagraph: UITextView!
    
    var movie: MovieViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        let backdropImagesUrl = URL(string: "https://image.tmdb.org/t/p/w200//\(movie!.backdropImagesUrlPath)?api_key=2e95638bfe81862d6fe6622fe5dcc18a")
        desciptionImage.lg.setImage(with: backdropImagesUrl)
        descriptionParagraph.text = movie!.description
    }
}
