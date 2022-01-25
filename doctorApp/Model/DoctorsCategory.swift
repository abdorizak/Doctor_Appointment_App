//
//  DoctorsCategory.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 12/20/21.
//

import Foundation


struct DoctorsCategorys: Codable {
    let categories: [Category]
}

struct Category: Codable {
    let _id: String
    let categoryName: String
    let categoryImage: String?
}


