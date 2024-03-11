//
//  PersistenceManager.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 08/03/2024.
//

import Foundation

// lets us know whether we are adding or removing follower from favorites
enum PersistanceActionType {
    case add, remove
}

// enum but not struct, because you can init an empty struct, but you cannot init empty enum

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    // passing the follower, actionType: adding or removing, completed: if sth went wrong present an error in ViewController
    static func updateWith(favorite: Follower, actionType: PersistanceActionType, completed: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            
            switch result {
                
                case .success(var favorites):
                    
                    switch actionType {
                        
                        case .add:
                            guard !favorites.contains(favorite) else {
                                // if we already have that guy taht we pass in in line 26 in favorites
                                completed(.alreadyInFavorites)
                                return
                            }
                            
                            favorites.append(favorite)
                        
                        case .remove:
                            favorites.removeAll { $0.login == favorite.login } // iterating through the array, anywhere the login equals the favorite login, we're going to remove all instances of it
                    }
                    
                    completed(save(favorites: favorites))
                
                case .failure(let error):
                    completed(error) // completion handler from line 26 (completed: @escaping (GFError?) -> Void), error from line 70
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([])) // not returning an error but an empty array, because if this favoritesData is nil, it means that we've never saved anything to favorites before (example of the very first time you ever trying to access this)
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
            
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> GFError? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites) // similar to line 23, but now we are setting the object
            return nil // returning nil, because there was no error
            
        } catch {
            return .unableToFavorite
        }
        
        
    }
}
