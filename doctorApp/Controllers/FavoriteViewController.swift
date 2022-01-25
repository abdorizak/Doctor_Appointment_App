//
//  FavoriteViewController.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 12/29/21.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    let tableView = UITableView()
    var favorites: [String?] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
        
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
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
    
}
