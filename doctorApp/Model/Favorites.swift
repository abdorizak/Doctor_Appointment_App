//
//  Favorites.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 1/25/22.
//

import Foundation

struct Favorited: Codable {
    let status: Int
    let favorited: [Favorited]
}


struct Favorite: Codable {
    let _id: String
    let doctorID: Doctor
    let userID: String
}

//{
//  "status": 200,
//  "favorited": [
//    {
//      "_id": "61eea6ef4766bb5f2a364c84",
//      "doctorID": {
//        "_id": "61d0a518ec6951b7c5bdbd12",
//        "image": "https://images.pexels.com/photos/3846038/pexels-photo-3846038.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
//        "name": "Drs yusra H.Hassan Ahmed",
//        "title": "Eye Doctor",
//        "price": "$20/h",
//        "availiable": "08:00am-05:00pm",
//        "patients": "3000+",
//        "experience": "10 years",
//        "certificate": "Master",
//        "description": "Doctors, also known as physicians, are licensed health professionals who maintain and restore human health through the practice of medicine. They examine patients, review their medical history, diagnose illnesses or injuries, administer treatment, and counsel patients on their health and well being.Doctors, also known as physicians, are licensed health professionals who maintain and restore human health through the practice of medicine. They examine patients, review their medical history, diagnose illnesses or injuries, administer treatment, and counsel patients on their health and well being.",
//        "tell": 2526543347801,
//        "categoryId": "61c820cbb7d2f06704bd32a7",
//        "__v": 0,
//        "isFavorited": true
//      },
//      "userID": "61d2bc942f89cd09b77a6423",
//      "__v": 0
//    }
//  ]
//}
