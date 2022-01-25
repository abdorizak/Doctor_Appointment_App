//
//  Apointment.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 1/14/22.
//

import Foundation


struct AppointmentResponse: Codable {
    let status: Int
    let message: String
    let Appointment: AppointmentRequestBody
}

struct AppointmentRequestBody: Codable {
    let phoneNumber: String
    let description: String
    let user: String?
    let doctor: String?
    let appointmentTime: String?
}


// Appointment
struct Appointments: Codable {
    let Appointments : [AppointmentUser]
}


struct AppointmentUser: Codable {
    let status: Bool
    let appointmentTime: String
    let doctor: Doctor
}


/*
{
  "status": 200,
  "message": "SuccessFull",
  "Appointments": [
    {
      "status": false,
      "_id": "61e559150ebc5f0f937a1901",
      "phoneNumber": "892939193",
      "description": "waaaw",
      "appointmentTime": "Tuesday, Jan 18, 2022 - 9:00 AM",
      "user": "61d2bc942f89cd09b77a6423",
      "doctor": {
        "_id": "61d0a518ec6951b7c5bdbd12",
        "image": "https://images.pexels.com/photos/3846038/pexels-photo-3846038.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
        "name": "Drs yusra H.Hassan Ahmed",
        "title": "Eye Doctor",
        "price": "$20/h",
        "availiable": "08:00am-05:00pm",
        "patients": "3000+",
        "experience": "10 years",
        "certificate": "Master",
        "description": "Doctors, also known as physicians, are licensed health professionals who maintain and restore human health through the practice of medicine. They examine patients, review their medical history, diagnose illnesses or injuries, administer treatment, and counsel patients on their health and well being.Doctors, also known as physicians, are licensed health professionals who maintain and restore human health through the practice of medicine. They examine patients, review their medical history, diagnose illnesses or injuries, administer treatment, and counsel patients on their health and well being.",
        "tell": 2526543347801,
        "categoryId": "61c820cbb7d2f06704bd32a7",
        "__v": 0
      },
      "__v": 0
    }
  ]
}
*/
