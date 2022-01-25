//
//  Favorites.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 1/25/22.
//

import Foundation

struct AddFavorited: Codable {
    let status: Int
    let message: String
}

struct FavoriteBody: Codable {
    let userID: String
    let doctorID: String
}




struct Favorites: Codable {
    let _id: String
    let doctorID: Doctor
    let userID: String
}

