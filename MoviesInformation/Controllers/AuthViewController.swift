//
//  AuthViewController.swift
//  MoviesInformation
//
//  Created by Juan Harrington on 3/05/22.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class AuthViewController: UIViewController {
    
    @IBOutlet weak var verticalStackView: UIStackView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Authentication"
        
        let defaults = UserDefaults.standard
        if let _ = defaults.value(forKey: "email") as? String,
           let _ = defaults.value(forKey: "provider") as? String{
            verticalStackView.isHidden = true
            
            let customViewController = storyboard!.instantiateViewController(withIdentifier: "HomeViewController") as!HomeViewController
            self.navigationController?.pushViewController(customViewController, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        verticalStackView.isHidden = false
    }
    
    @IBAction func logInButtonAction(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if let _ = result, error == nil{
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let customViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as!HomeViewController

                    self.navigationController?.pushViewController(customViewController, animated: false)
                }else{
                    print("error")
                    let alertController = UIAlertController(title: "error", message: "Se ha producido un error al registrar este usuario", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                self.handleLoginError(error: error)
            }
        }
    }
    
    
    private func showHomeViewController(){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewControllerInstance = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as!HomeViewController
            
            self.navigationController?.pushViewController(homeViewControllerInstance, animated: true)
    }
    
    func handleLoginError(error: Error?){
        if let error = error{
            let alertController = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "accept", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }else{
            showHomeViewController()
        }
    }

    @IBAction func googleButtonAction(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let googleConfigurate = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.signIn(with: googleConfigurate, presenting: self) { [unowned self] user, error in

          if let error = error {
            print(error)
            return
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
            print("failed to autheticate")
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential){result, error in
                handleLoginError(error: error)
            }
        }
    }
}
