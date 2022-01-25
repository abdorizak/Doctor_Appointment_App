//
//  DoctorProfileViewController.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 12/30/21.
//

import UIKit

class DoctorProfileViewController: UIViewController {
    
    @IBOutlet var doctorImageView: UIImageView!
    @IBOutlet var doctorName: UILabel!
    @IBOutlet var docotrTitle: UILabel!
    @IBOutlet var doctorPriceLbl: UILabel!
    @IBOutlet var doctorTime: UILabel!
    @IBOutlet var doctorPatientsLbl: UILabel!
    @IBOutlet var doctorExperienceLbl: UILabel!
    @IBOutlet var doctorCertificate: UILabel!
    @IBOutlet var doctorDescriptionLabel: UITextView!
    
    @IBOutlet var favoriteBtn: UIButton!
    
    var doctorDetails: Doctor?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getDoctorDetail()
        
    }
    
    func getDoctorDetail() {
        guard let doctorDetail = doctorDetails?.image else { return }
        NetworkManager.shared.downloadImage(from: doctorDetail) { [weak self] image in
            DispatchQueue.main.async {
                self?.doctorImageView.image = image
            }
        }
        doctorName.text             = doctorDetails?.name
        docotrTitle.text            = doctorDetails?.title
        doctorPriceLbl.text         = doctorDetails?.price
        doctorPatientsLbl.text      = doctorDetails?.patients
        doctorExperienceLbl.text    = doctorDetails?.experience
        doctorCertificate.text      = doctorDetails?.certificate
        doctorDescriptionLabel.text = doctorDetails?.description
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        guard let token = UserDefaults.standard.string(forKey: "jsonwebtoken"), let d = doctorDetails else { return }
        
        
        
//        NetworkManager.shared.addFavorite(token: token, d_id: d._id, d_image: d.image!, d_name: d.name, d_title: d.title, d_availiable: d.availiable, d_experience: d.experience, d_certificate: d.certificate, d_patients: d.patients, d_price: d.price, d_tell: d.tell, d_description: d.description, d_isFavorited: true, d_categoryId: d.categoryId) { [weak self] result in
//            switch result {
//            case .success(_):
//                DispatchQueue.main.async {
//                    self?.favoriteBtn.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
//                    self?.presentAlertOnMainThread(title: "Successfull", message: "You have successfull favorite this Doctor 🎉", btnTitle: "Ok")
//                }
//            case .failure(let err):
//                print(err.localizedDescription)
//            }
//        }
    }
    
    
    @IBAction func makeAppointment(_ sender: Any) {
       performSegue(withIdentifier: "segue.make.Appointment", sender: doctorDetails)
    }
    
    @IBAction func callDoctor(_ sender: Any) {
        //
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let appoint = segue.destination as? AppointmentViewController, let doctorDetails = sender as? Doctor {
            appoint.doctor = doctorDetails
             
        }
    }
    
}
