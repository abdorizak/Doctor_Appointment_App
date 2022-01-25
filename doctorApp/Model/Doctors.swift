//
//  Doctors.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 12/21/21.
//

import Foundation

struct Doctors : Codable {
    let doctors: [Doctor]
}

struct DoctorsCategory: Codable {
    let category: [Doctor]?
}

struct Doctor: Codable {
    let _id: String
    let image: String?
    let name: String
    let title: String
    let availiable: String
    let experience: String
    let certificate: String
    let patients: String
    let price: String
    let tell: Int
    let description: String
    let isFavorited: Bool
    let categoryId: String
}

struct CategoryDoctors: Codable {
    let status: Int
    let message: String
    let category: [Doctor]
}
