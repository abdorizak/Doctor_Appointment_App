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
    
    private let userID = UserDefaults.standard.string(forKey: "UserInfo")
    
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
        showLoadingview()
        NetworkManager.shared.addFavorites(userID: userID!, doctorID: doctorDetails?._id ?? "nil") { [weak self] result in
            switch result {
            case .success(let res):
                DispatchQueue.main.async {
                    self?.dismissLoding()
                    self?.presentAlertOnMainThread(title: "\(res.status == 200 ? "Successfull 🎉" : "Opps!")", message: "\(res.message)", btnTitle: "ok")
                }
            case .failure(let err):
                self?.presentAlertOnMainThread(title: "Error", message: err.rawValue, btnTitle: "ok")
            }
        }
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
