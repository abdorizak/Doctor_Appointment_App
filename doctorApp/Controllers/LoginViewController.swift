//
//  LoginViewController.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 12/29/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var usernameTextBox: UITextField!
    @IBOutlet var passwordTextBox: UITextField!
    
    enum Segue {
        static let home = "segue.main.Home"
        static let signUp = "segue.show.Singup"
    }
    
    var Info: LoginResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.bool(forKey: "IS_LOGGED_IN") {
            performSegue(withIdentifier: "segue.main.Home", sender: nil)
        }
    }
    
    
    func validateTexFields() {
        if (usernameTextBox.text?.isEmpty)! && (passwordTextBox.text?.isEmpty)! {
            presentAlertOnMainThread(title: "Opps!", message: "Username and password cannot be Empty.", btnTitle: "OK")
        } else if (usernameTextBox.text?.isEmpty)! {
            presentAlertOnMainThread(title: "Opps!", message: "Username cannot be Empty.", btnTitle: "OK")
        } else if (passwordTextBox.text?.isEmpty)! {
            presentAlertOnMainThread(title: "Opps!", message: "password cannot be Empty.", btnTitle: "OK")
        }
    }
    
    @IBAction func didTapLoginBtn(_ sender: Any) {
        validateTexFields()
        showLoadingview()
        NetworkManager.shared.login(username: self.usernameTextBox.text!, password: self.passwordTextBox.text!) { loginResponse in
            switch loginResponse {
            case .success(let res):
                DispatchQueue.main.async {
                    UserDefaults.standard.setValue(res.userInfo?._id, forKey: "UserInfo")
                    UserDefaults.standard.setValue(res.token, forKey: "jsonwebtoken")
                    UserDefaults.standard.set(true, forKey: "IS_LOGGED_IN")
                    self.performSegue(withIdentifier: Segue.home, sender: nil)
                    self.dismissLoding()
                }
            case .failure(let err):
                self.presentAlertOnMainThread(title: "opps!", message: "\(err)", btnTitle: "ok")
                self.dismissLoding()
            }
        }
    }
    
    @IBAction func didTapSignUpBtn(_ sender: Any) {
        performSegue(withIdentifier: Segue.signUp, sender: nil)
    }
    
    
    
}
