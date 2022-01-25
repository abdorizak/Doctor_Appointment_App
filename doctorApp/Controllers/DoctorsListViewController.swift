//
//  DoctorsListViewController.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 12/23/21.
//

import UIKit

class DoctorsListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var doctorsList = [Doctor]()
    var selectedDoctor: Doctor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = "All Doctors"
        navigationController?.navigationBar.prefersLargeTitles = true
        registryCell()
        getListOfDoctors()
    }
    
    func getListOfDoctors(){
        guard let token = UserDefaults.standard.string(forKey: "jsonwebtoken") else { return }
        NetworkManager.shared.getDoctors(token: token) { result in
            switch result {
            case .success(let doctors):
                DispatchQueue.main.async {
                    self.doctorsList = doctors.doctors
                    self.tableView.reloadData()
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func registryCell() {
        tableView.register(UINib(nibName: DoctorsListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DoctorsListTableViewCell.identifier)
    }

    
}

extension DoctorsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        doctorsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DoctorsListTableViewCell.identifier, for: indexPath) as! DoctorsListTableViewCell
        cell.display(ListOf: doctorsList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDoctor = doctorsList[indexPath.row]
        performSegue(withIdentifier: "segue.main.details", sender: selectedDoctor)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let doctor = segue.destination as? DoctorProfileViewController, let sender = sender as? Doctor {
            doctor.doctorDetails = sender
        }
    }
    
}
