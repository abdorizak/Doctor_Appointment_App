//
//  Constants.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 1/14/22.
//

import Foundation

struct Constants {
    static let login_URL        = "http://localhost:9000/api/auth/login"
    static let doctors          = "http://localhost:9000/api/doctors/"
    static let categoryDoctors  = "http://localhost:9000/api/doctors/categoryDoctors/"
    static let categorys        = "http://localhost:9000/api/category/"
    static let appintment       = "http://localhost:9000/api/appointment/make-appointment"
    static let create_user      = "http://localhost:9000/api/user/create_user"
    static let user_Appoinments = "http://localhost:9000/api/appointment/user_appointment/"
    static let user             = "http://localhost:9000/api/user/me/"
    static let makeFavorite   = "http://localhost:9000/api/create-Favorites"
}
