//
//  SingUpViewController.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 12/29/21.
//

import UIKit

class SingUpViewController: UIViewController {

    @IBOutlet var fullNameTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var TextFields : [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
    }
    
    func configureTextField() {
        for TextField in TextFields {
            TextField.layer.cornerRadius = 10
            TextField.clipsToBounds = false
            TextField.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
            TextField.layer.shadowColor = UIColor.black.cgColor
            TextField.layer.shadowOpacity = 0.1
            TextField.layer.shadowOffset = .zero
        }
    }
    
    func validateTexFields() {
        if (fullNameTextField.text?.isEmpty)! && (usernameTextField.text?.isEmpty)! && (passwordTextField.text?.isEmpty)! {
            presentAlertOnMainThread(title: "Opps!", message: "fullname username and password cannot be Empty.", btnTitle: "OK")
        } else if (fullNameTextField.text?.isEmpty)! {
            presentAlertOnMainThread(title: "Opps!", message: "fullname cannot be Empty.", btnTitle: "OK")
        } else if (usernameTextField.text?.isEmpty)! {
            presentAlertOnMainThread(title: "Opps!", message: "username cannot be Empty.", btnTitle: "OK")
        } else if (passwordTextField.text?.isEmpty)! {
            presentAlertOnMainThread(title: "Opps!", message: "password cannot be Empty.", btnTitle: "OK")
        }
    }
    
    @IBAction func didTapSignUp(_ sender: Any) {
        validateTexFields()
        showLoadingview()
        NetworkManager.shared.singUp(name: fullNameTextField.text!, username: usernameTextField.text!, password: passwordTextField.text!) { [weak self] result in
            switch result {
            case .success(let res):
                DispatchQueue.main.async {
                    self?.dismissLoding()
                    self?.presentAlertOnMainThread(title: "\(res.status == 200 ? "Successfull 🎉" : "Opps!")", message: "\(res.message)", btnTitle: "ok")
                }
                
            case .failure(let err):
                self?.dismissLoding()
                self?.presentAlertOnMainThread(title: "Oops!", message: "\(err)🎉", btnTitle: "cancel")
            }
        }
    }
    

}
