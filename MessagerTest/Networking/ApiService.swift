//
//  ApiService.swift
//  MessagerTest
//
//  Created by Virgil Martinez on 11/15/20.
//

import Foundation

class ApiService {
    
    private var dataTask: URLSessionDataTask?
    var tempKeys: DecodedArray?
    
    func getAllMessages(completion: @escaping (Result<DecodedArray, Error>) -> Void) {

        let messagesURL = "https://abraxvasbh.execute-api.us-east-2.amazonaws.com/proto/messages"
        
        guard let url = URL(string: messagesURL) else { return }
        
        // URL session that will run in the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // ERROR
            if let error = error {
                completion(.failure(error))
                print("[ERROR] Data task failed: \(error.localizedDescription)")
                return
            }
            
            // EMPTY RESPONSE
            guard let response = response as? HTTPURLResponse else {
                // TODO: - handle empty response
                print("[DEBUG] Empty response")
                return
            }
            
            print("[INFO] Response status code: \(response.statusCode)")
            
            //EMPTY DATA
            guard let data = data else {
                // TODO: - handle empty data
                print("[DEBUG] Empty data")
                return
            }
            
            do {
                // Parse data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Body.self, from: data)

                DispatchQueue.main.async {
                    completion(.success(jsonData.body))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        
        dataTask?.resume()
    }
    

}
