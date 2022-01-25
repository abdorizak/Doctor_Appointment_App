//
//  ViewController.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 12/20/21.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var categoryCollectionView: UICollectionView!
    @IBOutlet var topDoctorsTableView: UITableView!
    
    var doctors = [Doctor]()
    var selectedDoctor: Doctor?
    var category = [Category]()
    var selectedCategory: Category?
    
    var gearItems = ["Profile", "Sigout"]
    
    enum Gears: CaseIterable {
        case profile
        case singout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationUI()
        fetchCategorie()
        fetchTopDoctors()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCategorie()
        fetchTopDoctors()
    }
    
    func configurationUI() {
        topDoctorsTableView.dataSource = self
        topDoctorsTableView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        
        navigationItem.title = "Doctor Appointment App"
        let notification = UIBarButtonItem(image: UIImage(systemName: "bell.badge"), style: .plain, target: self, action: #selector(appointment_notifications))
        let items = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(didtapGear))
        navigationItem.rightBarButtonItems = [items, notification]
        
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        topDoctorsTableView.register(UINib(nibName: TopDoctorsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TopDoctorsTableViewCell.identifier)
    }
    
    @objc func appointment_notifications() {
        performSegue(withIdentifier: "segue.notification", sender: nil)
    }
     
    @objc func didtapGear() {
        let ac = UIAlertController(title: "Setting", message: nil, preferredStyle: .actionSheet)
        for item in gearItems {
            ac.addAction(UIAlertAction(title: item, style: .default, handler: didTappedGear))
        }
        ac.addAction(UIAlertAction(title: "cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true, completion: nil)
    }
    
    @objc func didTappedGear(action: UIAlertAction){
        guard let actionTitle = action.title else { return }
        if actionTitle == "Profile" {
            self.performSegue(withIdentifier: "segue.profile", sender: nil)
        } else {
            let ac =  UIAlertController(title: "Sing Out", message: "Are you sure?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            ac.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in
                NetworkManager.shared.singOut { [weak self] singOut in
                    if singOut {
                        DispatchQueue.main.async {
                            UserDefaults.standard.set(false, forKey: "IS_LOGGED_IN")
                            self?.performSegue(withIdentifier: "segue.loginScrean", sender: nil)
                        }
                    }
                }
            }))
            present(ac, animated: true, completion: nil)
        }

    }
    
    func fetchCategorie() {
        NetworkManager.shared.getCategorys() { result in
            switch result {
            case .success(let category):
                DispatchQueue.main.async {
                    self.category = category.categories
                    self.categoryCollectionView.reloadData()
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
    }
    
    func fetchTopDoctors() {
        NetworkManager.shared.getTopDoctors() { result in
            switch result {
            case .success(let doctors):
                DispatchQueue.main.async {
                    self.doctors = doctors.doctors
                    self.topDoctorsTableView.reloadData()
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        category.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        cell.display(category: category[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = category[indexPath.row]
        performSegue(withIdentifier: "segue.list.categoryDoctors", sender: selectedCategory)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let categorydetail = segue.destination as? ListOfCategoryDoctorsViewController, let categorySend = sender as? Category {
            categorydetail.category = categorySend
        } else if let doctor = segue.destination as? DoctorProfileViewController, let d = sender as? Doctor {
            doctor.doctorDetails = d
        }
    }

}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        doctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = topDoctorsTableView.dequeueReusableCell(withIdentifier: TopDoctorsTableViewCell.identifier, for: indexPath) as! TopDoctorsTableViewCell
        cell.display(Top: doctors[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDoctor = doctors[indexPath.row]
        performSegue(withIdentifier: "segue.doctor.details", sender: selectedDoctor)
    }
    
    
    
}
