//
//  Errors.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 1/6/22.
//

import Foundation

enum AuthenticationError: Error {
    case invalidUsernameOrPassword
    case invalidCredentials
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case custom(errorMessage: String)
}

enum DoctorAppointmentErrors: String, Error {
    case invalidUsernameOrPassword = "this username created an invalid request. please try again.."
    case invalidCredentials = "please check that you have used the correct email and password"
    case unableTopComplete = "Unable to complete you request. Please check your Internet connection.."
    case inValidResponse = "Invalid response from the server. please try again."
    case inVlaidData = "the data recevied from the server was Invalid. please try again."
    case unableToFavorite = "There was an error favoriting this user. Please Try again."
    case alreadyInFavorite = "You've already Favorite this user. You must really like them!"
}


