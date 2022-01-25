//
//  User.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 1/8/22.
//

import Foundation

struct User: Codable {
    let _id: String
    let name: String
    let username: String
}

struct UserBody: Codable {
    let name: String
    let username: String
    let password: String
}


struct UserResponse: Codable {
    let status: Int
    let message: String
}

struct UserInfo: Codable {
    let status: Int
    let message: String
    let userinfo: User
}
