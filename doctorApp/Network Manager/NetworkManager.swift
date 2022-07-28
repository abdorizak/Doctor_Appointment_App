//
//  NetworkManager.swift
//  doctorApp
//
//  Created by Abdirizak Hassan on 1/2/22.
//

import UIKit
final class NetworkManager {
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    
    private let token = UserDefaults.standard.string(forKey: "jsonwebtoken")
    
    
    func getFavorites(userID: String, completion: @escaping (Result<Favorited, DoctorAppointmentErrors>) -> Void) {
        
        guard let url = URL(string: Constants.favorites + "\(userID)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        guard let token = token else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.inValidData))
                return
            }
            
            do {
                let res = try JSONDecoder().decode(Favorited.self, from: data)
                completion(.success(res))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
        
    }
    
    
    // Add Favorites
    func addFavorites(userID: String, doctorID: String, completion: @escaping (Result<AddFavorited, DoctorAppointmentErrors>) -> Void) {
        
        guard let url = URL(string: Constants.makeFavorite) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let body = FavoriteBody(userID: userID, doctorID: doctorID)
        
        guard let jsonData = try? JSONEncoder().encode(body) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        guard let token = token else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        request.httpBody = jsonData
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.inValidData))
                return
            }
            
            do {
                let res = try JSONDecoder().decode(AddFavorited.self, from: data)
                completion(.success(res))
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
        
    }
    
    
    // Get User Appointments
    func userAppointments(token: String, userID: String, completion: @escaping (Result<Appointments, DoctorAppointmentErrors>) -> Void) {
        guard let url = URL(string: Constants.user_Appoinments + "\(userID)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.inValidData))
                return
            }
            
            do {
                let res = try JSONDecoder().decode(Appointments.self, from: data)
                completion(.success(res))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    
    // get UserInof
    func getUserInfo(token: String, userID: String, completion: @escaping(Result<UserInfo, DoctorAppointmentErrors>) -> Void) {
        
        guard let url = URL(string: Constants.user + "\(userID)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.inValidData))
                return
            }
            
            do{
                let userinfo = try JSONDecoder().decode(UserInfo.self, from: data)
                completion(.success(userinfo))
            } catch {
                print(error)
            }

        }.resume()
        
    }
    

    // Get List Doctors in Category
    func getlistDoctorsInCategory(token: String, categoryID: String, completion: @escaping (Result<CategoryDoctors, DoctorAppointmentErrors>) -> Void){
        
        guard let url = URL(string: Constants.categoryDoctors + "\(categoryID)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.inValidData))
                return
            }
            
            do{
                let result = try JSONDecoder().decode(CategoryDoctors.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingError))
            }

        }.resume()
    }

    // RequestAppointment
    func makeAppointment(token: String, userId: String, doctorId: String, tell: String, description: String, date: String, completion: @escaping (Result<AppointmentResponse, DoctorAppointmentErrors>) -> Void ) {
        
        guard let url = URL(string: Constants.appintment) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let body = AppointmentRequestBody(phoneNumber: tell, description: description, user: userId, doctor: doctorId, appointmentTime: date)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.inValidData))
                return
            }
            
            guard let res = try? JSONDecoder().decode(AppointmentResponse.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            completion(.success(res))
            
        }.resume()
        
        
    }
    
    // get DoctorInfo
    
    func getDocotorInfo(token: String, name: String, completion: @escaping (Result<Doctors, DoctorAppointmentErrors>) -> Void) {
        // ...
    }
    
    func getCategorys( completion: @escaping (Result<DoctorsCategorys, DoctorAppointmentErrors>) -> Void) {
        guard let url = URL(string: Constants.categorys) else {
            completion(.failure(.invalidURL))
            return
        }
        
        guard let token = token else {
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.inValidData))
                return
            }
            
            do{
                let categories = try JSONDecoder().decode(DoctorsCategorys.self, from: data)
                completion(.success(categories))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
        
    }
    
    func getTopDoctors(completion: @escaping (Result<Doctors, DoctorAppointmentErrors>) -> Void) {
        // Do something
        guard let url = URL(string: Constants.doctors + "/top-doctors") else {
            completion(.failure(.invalidURL))
            return
        }
        guard let token = token else {
            return
        }

        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.inValidData))
                return
            }
            
            do{
                let doctors = try JSONDecoder().decode(Doctors.self, from: data)
                completion(.success(doctors))
            } catch {
                completion(.failure(.decodingError))
            }

        }.resume()
    }
    
    // GetAll Doctors
    func getDoctors(completion: @escaping (Result<Doctors, DoctorAppointmentErrors>) -> Void) {
        // Do something
        guard let url = URL(string: Constants.doctors) else {
            completion(.failure(.invalidURL))
            return
        }
        guard let token = token else {
            return
        }
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.inValidData))
                return
            }
            
            do{
                let doctors = try JSONDecoder().decode(Doctors.self, from: data)
                completion(.success(doctors))
            } catch {
                completion(.failure(.decodingError))
            }

        }.resume()
        
    }
    
    
    func singUp(name: String, username: String, password: String, completion: @escaping (Result<UserResponse, DoctorAppointmentErrors>) -> Void) {
        guard let url = URL(string: Constants.create_user) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let body = UserBody(name: name, username: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.inValidData))
                return
            }
            
            do{
                let res = try JSONDecoder().decode(UserResponse.self, from: data)
                completion(.success(res))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    
    // Login
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, DoctorAppointmentErrors>) -> Void) {
            
        guard let url = URL(string: Constants.login_URL) else {
            completion(.failure(.invalidURL))
                return
            }
            
            let body = LoginRequestBody(username: username, password: password)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONEncoder().encode(body)
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil else {
                    completion(.failure(.inValidData))
                    return
                }
                
                guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                    completion(.failure(.invalidUsernameOrPassword))
                    return
                }
                
                guard let _ = loginResponse.token else {
                    completion(.failure(.invalidCredentials))
                    return
                }
                
                completion(.success(loginResponse))
                
            }.resume()
            
        }

    
    // downloding Image and catch
    public func downloadImage(from urlString: String, completion: @escaping(UIImage?)-> Void) {
        // Do something
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            self?.cache.setObject(image, forKey: cacheKey)
            completion(image)
            
        }.resume()
        
    }
    
    
    func singOut(completion: (Bool) -> Void){
        UserDefaults.standard.removeObject(forKey: "jsonwebtoken")
        completion(true)
    }
}


