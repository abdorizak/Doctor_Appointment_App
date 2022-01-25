//
//  LoginResponse.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 1/7/22.
//

import Foundation

struct LoginRequestBody: Codable {
    let username: String
    let password: String
}

struct LoginResponse: Codable {
    let success: Bool?
    let userInfo: User?
    let token: String?
}
