//
//  NotificationViewController.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 1/19/22.
//

import UIKit

class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    private let token = UserDefaults.standard.string(forKey: "jsonwebtoken")
    private let userID = UserDefaults.standard.string(forKey: "UserInfo")
    
    var appointmentUser = [AppointmentUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Appointment Notifications"
        tableView.dataSource = self
        tableView.delegate   = self
        getNotifications()
        tableView.register(UINib(nibName: AppointmentsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AppointmentsTableViewCell.identifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNotifications()
    }
    
    func getNotifications() {
        NetworkManager.shared.userAppointments(token: token ?? "nil", userID: userID ?? "nil") { [weak self] result in
            switch result {
            case .success(let n):
                DispatchQueue.main.async {
                    self?.appointmentUser = n.Appointments
                    self?.tableView.reloadData()
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        appointmentUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentsTableViewCell.identifier, for: indexPath) as! AppointmentsTableViewCell
        cell.displayUserAppointments(userAppointments: appointmentUser[indexPath.row])
        return cell
    }
    
    

}
