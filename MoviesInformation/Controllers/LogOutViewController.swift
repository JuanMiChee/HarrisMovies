//
//  logOutViewController.swift
//  MoviesInformation
//
//  Created by Juan Harrington on 3/05/22.
//

import UIKit

class LogOutViewController: UIViewController {
    
    enum providerType: String {
        case basic
    }
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwodLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    
    private let email : String
    private let provider: providerType
    
    init(email: String, provider: providerType) {
        self.email = email
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "logOut"
    }
    
    @IBAction func logOutButtonAction(_ sender: Any) {
    }
    
    

}
