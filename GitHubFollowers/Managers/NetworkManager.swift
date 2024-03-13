//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 15/02/2024.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager() // static: every Network manager will have this variable on it
    private init() { 
        decoder.keyDecodingStrategy     = .convertFromSnakeCase // Follower.swift, line: 12
        decoder.dateDecodingStrategy    = .iso8601
    }
    
    private let baseURL          = "https://api.github.com/users/"
    private let perPageFollowers = "?per_page=100"
    
    let cache   = NSCache<NSString, UIImage>()
    
    let decoder = JSONDecoder()
    
//    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void)  {
//        let endpoint = baseURL + "\(username)/followers\(perPageFollowers)&page=\(page)"
//        
//        guard let url = URL(string: endpoint) else {
//            completed(.failure(.invalidUsername))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            
//            if let _ = error {  // if the error exists
//                completed(.failure(.unableToComplete))
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {    // https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
//                completed(.failure(.invalidResponse))
//                return
//            }
//            
//            guard let data = data else {
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase // Follower.swift, line: 12
//                
//                let followers = try decoder.decode([Follower].self, from: data)
//                completed(.success(followers))
//                
//            } catch {
//                completed(.failure(.invalidData))
//            }
//        }
//        
//        task.resume()
//     
//    }
    
    // async  - this is an async func, we ban youse async/await
    // throws - it can throw an error
    func getFollowers(for username: String, page: Int) async throws -> [Follower] {
        let endpoint = baseURL + "\(username)/followers\(perPageFollowers)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            throw GFError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url) // if this fails, it throws an error
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            // https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
            throw GFError.invalidResponse
        }
        
        do {
            return try decoder.decode([Follower].self, from: data)
            
        } catch {
            throw GFError.invalidData
            
        }
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
                
                decoder.keyDecodingStrategy = .convertFromSnakeCase // Follower.swift, line: 12
                
                
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
                
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
     
    }
    
    // no result type: if it fails, the placeholder image is displayed
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        // if we already have an image in cache: no need for networking stuff
        if let image = cache.object(forKey: cacheKey) {
            completed(image) // self.image = image is now completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                      completed(nil)
                      return
            }
            
            // if we finally have an image:
            self.cache.setObject(image, forKey: cacheKey) // send it to the cache
            
            completed(image)
        }
        
        task.resume()
    }
}
