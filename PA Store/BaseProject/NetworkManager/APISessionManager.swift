//
//  APISessionManager.swift
//  PA Store
//
//  Created by Haroon Shoukat on 03/02/2024.
//

import Foundation

class APISessionManager {
    
    static let shared = APISessionManager()
    
    
    func sendData(baseURL: String, parameters: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)") else {
            // Handle invalid URL
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            completion(.failure(error))
            return
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
        
        task.resume()
    }
    
    func sendDataInBackground(url: String, parameters: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string: "\(url)") else {
                // Handle invalid URL
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
                }
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }
                
                if let data = data {
                    DispatchQueue.main.async {
                        completion(.success(data))
                    }
                }
            }
            
            task.resume()
        }
    }
    
    
    func sendDataInBackground(url: String, jsonString: String) {
        // Set your API endpoint URL
        let apiUrl = URL(string: url)!
        
        // Create a URLRequest with the URL
        var request = URLRequest(url: apiUrl)
        
        // Set the HTTP method to POST
        request.httpMethod = "POST"
        
        // Set the HTTP body with your JSON string
        request.httpBody = jsonString.data(using: .utf8)
        
        // Create a URLSession configuration for background tasks
        let config = URLSessionConfiguration.background(withIdentifier: "com.haroon.pastorev2")
        
        // Create a URLSession with the configuration
        let session = URLSession(configuration: config)
        
        // Create a data task
        let task = session.dataTask(with: request) { (data, response, error) in
            // Handle the response here
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let data = data {
                // Parse the response data if needed
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("Response JSON: \(json)")
                } catch {
                    print("Error parsing JSON: \(error.localizedDescription)")
                }
            }
        }
        
        // Resume the task to start the request
        task.resume()
    }
    
}
