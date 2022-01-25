//
//  AppointmentViewController.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 1/14/22.
//

import UIKit

class AppointmentViewController: UIViewController {
    
    
    @IBOutlet var tellTextfeild: UITextField!
    @IBOutlet var descriptionTextfeild: UITextField!
    @IBOutlet var chooseDate: UITextField!
    
    private let token = UserDefaults.standard.string(forKey: "jsonwebtoken")
    private let userID = UserDefaults.standard.string(forKey: "UserInfo")
    
    var doctor: Doctor?
    
//    private let datePicker: UIDatePicker = {
//        let picker = UIDatePicker()
//        picker.datePickerMode = .dateAndTime
//        
//        return picker
//    }()
    
    private lazy var dateTimePicker: DateTimePicker = {
       let picker = DateTimePicker()
        picker.setup()
        picker.didSelectDates = { [weak self] dte in
            let text = Date.buildTimeRangeString(date: dte)
            self?.chooseDate.text = text
        }
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseDate.inputView = dateTimePicker.inputView
    }
    
    func validateTexFields() {
        if (tellTextfeild.text?.isEmpty)! && (descriptionTextfeild.text?.isEmpty)! && (chooseDate.text?.isEmpty)! {
            presentAlertOnMainThread(title: "Opps!", message: "TellPhone number and Description and Date cannot be Empty.", btnTitle: "OK")
        } else if (tellTextfeild.text?.isEmpty)! {
            presentAlertOnMainThread(title: "Opps!", message: "TellPhone cannot be Empty.", btnTitle: "OK")
        } else if (descriptionTextfeild.text?.isEmpty)! {
            presentAlertOnMainThread(title: "Opps!", message: "Description cannot be Empty.", btnTitle: "OK")
        }else if (chooseDate.text?.isEmpty)! {
            presentAlertOnMainThread(title: "Opps!", message: "Date cannot be Empty.", btnTitle: "OK")
        }
    }
    
    @IBAction func didTapSend(_ sender: Any) {
        validateTexFields()
        print(doctor?._id ?? "nil")
        print(token ?? "")
        showLoadingview()
        NetworkManager.shared.makeAppointment(token: token ?? "Is Empty", userId: userID ?? "" , doctorId: doctor?._id ?? "", tell: self.tellTextfeild.text!, description: self.descriptionTextfeild.text!, date: chooseDate.text!) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                 print("Successfull")
                 self?.dismissLoding()
                }
            case .failure(let err):
                print(err)
               self?.dismissLoding()
            }
        }
            
        }
}
