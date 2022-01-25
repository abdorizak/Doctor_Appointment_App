//
//  ListOfCategoryDoctorsViewController.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 1/14/22.
//

import UIKit

class ListOfCategoryDoctorsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!

    var category: Category?
    var doctor = [Doctor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(category?.categoryName ?? "")"
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: DoctorsListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DoctorsListTableViewCell.identifier)

        guard let token = UserDefaults.standard.string(forKey: "jsonwebtoken"), let category_id = category?._id else { return }
        showLoadingview()
        NetworkManager.shared.getlistDoctorsInCategory(token: token, categoryID: category_id) { [weak self] result in
            switch result {
            case .success(let list):
                DispatchQueue.main.async {
                    self?.doctor = list.category
                    self?.tableView.reloadData()
                    self?.dismissLoding()
                }
            case .failure(let err):
                print(err)
            }
        }
        
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        doctor.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DoctorsListTableViewCell.identifier, for: indexPath) as! DoctorsListTableViewCell
        cell.displayCategory(dcotrosIn: doctor[indexPath.row])
        return cell
    }

}
