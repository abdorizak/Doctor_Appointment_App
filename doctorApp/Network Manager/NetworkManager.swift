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
    
    
    // Another way of Add Favorites
    func addFavorites(token: String, dotorID: String, userID: String, completion: @escaping (Result<>) -> Void) {
        
    }
    
    // Add Favorites
    func addFavorite(token: String,
                     d_id: String,
                     d_image: String,
                     d_name: String,
                     d_title: String,
                     d_availiable: String,
                     d_experience: String,
                     d_certificate: String,
                     d_patients: String,
                     d_price: String,
                     d_tell: Int,
                     d_description: String,
                     d_isFavorited: Bool,
                     d_categoryId: String,
                     completion: @escaping (Result<UpdatedDoctor, NetworkError>) -> Void){
        
        guard let url = URL(string: Constants.favoriteDoctor + "\(d_id)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        let body = updateDoctorBody(image: d_image, name: d_name, title: d_title, availiable: d_availiable, experience: d_experience, certificate: d_certificate, patients: d_patients, price: d_price, tell: d_tell, description: d_description, isFavorited: d_isFavorited, categoryId: d_categoryId)
        
        guard let jsonData = try? JSONEncoder().encode(body) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
                
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        request.httpBody = jsonData
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }

            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }

            do {
//               let res = try JSONDecoder().decode(UpdatedDoctor.self, from: data)
                let res = try JSONSerialization.jsonObject(with: data, options: [])
                print(res)
//              completion(.success(res))
            } catch {
                completion(.failure(.decodingError))
            }

        }.resume()
        
    }
    
    // Get User Appointments
    func userAppointments(token: String, userID: String, completion: @escaping (Result<Appointments, NetworkError>) -> Void) {
        guard let url = URL(string: Constants.user_Appoinments + "\(userID)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let res = try JSONDecoder().decode(Appointments.self, from: data)
//                print(res)
                completion(.success(res))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    
    // get UserInof
    func getUserInfo(token: String, userID: String, completion: @escaping(Result<UserInfo, NetworkError>) -> Void) {
        
        guard let url = URL(string: Constants.user + "\(userID)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
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
    func getlistDoctorsInCategory(token: String, categoryID: String, completion: @escaping (Result<CategoryDoctors, NetworkError>) -> Void){
        
        guard let url = URL(string: Constants.categoryDoctors + "\(categoryID)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            do{
                let result = try JSONDecoder().decode(CategoryDoctors.self, from: data)
//                let result = try JSONSerialization.jsonObject(with: data, options: [])
                completion(.success(result))
            } catch {
                completion(.failure(.decodingError))
            }

        }.resume()
    }

    // RequestAppointment
    func makeAppointment(token: String, userId: String, doctorId: String, tell: String, description: String, date: String, completion: @escaping (Result<AppointmentResponse, NetworkError>) -> Void ) {
        
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
                completion(.failure(.noData))
                return
            }
            
            guard let res = try? JSONDecoder().decode(AppointmentResponse.self, from: data) else {
                completion(.failure(.custom(errorMessage: "Invalid Body")))
                return
            }
            
            
            completion(.success(res))
            
        }.resume()
        
        
    }
    
    // get DoctorInfo
    
    func getDocotorInfo(token: String, name: String, completion: @escaping (Result<Doctors, NetworkError>) -> Void) {
        // ...
    }
    
    func getCategorys(token: String, completion: @escaping (Result<DoctorsCategorys, NetworkError>) -> Void) {
        guard let url = URL(string: Constants.categorys) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
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
    
    func getTopDoctors(token: String, completion: @escaping (Result<Doctors, NetworkError>) -> Void) {
        // Do something
        guard let url = URL(string: Constants.doctors + "/top-doctors") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            do{
                let doctors = try JSONDecoder().decode(Doctors.self, from: data)
//                print(doctors)
                completion(.success(doctors))
            } catch {
                completion(.failure(.decodingError))
            }

        }.resume()
        
    }
    
    // GetAll Doctors
    func getDoctors(token: String, completion: @escaping (Result<Doctors, NetworkError>) -> Void) {
        // Do something
        guard let url = URL(string: Constants.doctors) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            do{
                let doctors = try JSONDecoder().decode(Doctors.self, from: data)
//                print(doctors)
                completion(.success(doctors))
            } catch {
                completion(.failure(.decodingError))
            }

        }.resume()
        
    }
    
    
    func singUp(name: String, username: String, password: String, completion: @escaping (Result<UserResponse, NetworkError>) -> Void) {
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
                completion(.failure(.noData))
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
    

    
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, AuthenticationError>) -> Void) {
            
        guard let url = URL(string: Constants.login_URL) else {
                completion(.failure(.custom(errorMessage: "URL is not correct")))
                return
            }
            
            let body = LoginRequestBody(username: username, password: password)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONEncoder().encode(body)
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil else {
                    completion(.failure(.custom(errorMessage: "No data")))
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


