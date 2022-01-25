//
//  AppointmentsTableViewCell.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 1/19/22.
//

import UIKit

class AppointmentsTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: AppointmentsTableViewCell.self)
    
    @IBOutlet var doctornamelbl: UILabel!
    @IBOutlet var doctortitlelbl: UILabel!
    @IBOutlet var isAceptedlbl: UILabel!
    @IBOutlet var doctorImage: UIImageView!
    
    @IBOutlet var isAccepitableView: UIView!
    
    
    
    func displayUserAppointments(userAppointments appointment: AppointmentUser)  { 
        if appointment.status == true {
            isAccepitableView.backgroundColor = .green
            isAceptedlbl.text = "Accepted"
        } else {
            isAccepitableView.backgroundColor = .systemRed
            isAceptedlbl.text = "Pendding"
        }
        NetworkManager.shared.downloadImage(from: appointment.doctor.image ?? "") { [weak self] image in
            DispatchQueue.main.async {
                self?.doctorImage.image = image
            }
        }
        doctornamelbl.text  = appointment.doctor.name
        doctortitlelbl.text = appointment.doctor.title
        
    }
    
    
}
