//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 15/02/2024.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager() // static: every Network manager will have this variable on it
    private init() { }
    
    private let baseURL          = "https://api.github.com/users/"
    private let perPageFollowers = "?per_page=100"
    
    let cache = NSCache<NSString, UIImage>()
    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void)  {
        let endpoint = baseURL + "\(username)/followers\(perPageFollowers)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {  // if the error exists
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {    // https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // Follower.swift, line: 12
                
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
                
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
     
    }
    
    func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>) -> Void)  {
        let endpoint = baseURL + "\(username)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {  // if the error exists
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // Follower.swift, line: 12
                decoder.dateDecodingStrategy = .iso8601
                
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
                
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
     
    }
}
