//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 15/02/2024.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager() // static: every Network manager will have this variable on it
    private init() { }
    
    let baseURL = "https://api.github.com/users/"
    let perPageFollowers = "?per_page=100"
    
    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, String?) -> Void)  {
        let endpoint = baseURL + "\(username)/followers\(perPageFollowers)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(nil, "This username created an invalid request. Please try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {  // if the error exists
                completed(nil, "Unable to complete your request. Please check your internet connection.")
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {    // https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
                completed(nil, "Invalid response from the server. Please try again.")
                return
            }
            
            guard let data = data else {
                completed(nil, "The data received from the server is invalid. Please try again.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // Follower.swift, line: 12
                
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
                
            } catch {
                completed(nil, "The data received from the server was invalid. Please try again.")
            }
        }
        
        task.resume()
     
    }
}
