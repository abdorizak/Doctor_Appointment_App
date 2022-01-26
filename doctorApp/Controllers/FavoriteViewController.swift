//
//  FavoriteViewController.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 12/29/21.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    let tableView = UITableView()

    var doctor = [Doctor]()
    private let userID = UserDefaults.standard.string(forKey: "UserInfo")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        getFavorite()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorite()
    }
    
    
    func getFavorite() {
        NetworkManager.shared.getFavorites(userID: userID!) { [weak self] result in
            switch result {
            case .success(let res):
                DispatchQueue.main.async {
                    let doctorDetails = res.favorited.map { f in
                        f.doctorID
                    }
                    self?.doctor = doctorDetails
                    self?.tableView.reloadData()
                }
            case .failure(let err):
                print(err.rawValue)
            }
        }
    }
    
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 102
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: FavoritesCell.identifier, bundle: nil), forCellReuseIdentifier: FavoritesCell.identifier)
    }
    
    

}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        doctor.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.identifier, for: indexPath) as! FavoritesCell
        cell.display(Favorite: doctor[indexPath.row])
        return cell
    }
    
}
