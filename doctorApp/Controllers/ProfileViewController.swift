//
//  ProfileViewController.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 1/20/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var fullnamelbl: UILabel!
    @IBOutlet var usernamelbl: UILabel!
    
    private let token = UserDefaults.standard.string(forKey: "jsonwebtoken")
    private let userID = UserDefaults.standard.string(forKey: "UserInfo")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        getUserInfo()
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(token: token ?? "nill", userID: userID ?? "nill") { [weak self] result in
            switch result {
            case .success(let info):
                DispatchQueue.main.async {
                    self?.fullnamelbl.text = info.userinfo.name
                    self?.usernamelbl.text = info.userinfo.username
                }
            case .failure(let err):
                print(err)
            }
        }
    }
}
