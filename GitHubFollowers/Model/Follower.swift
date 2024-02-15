//
//  Follower.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 15/02/2024.
//

import Foundation

struct Follower: Codable {
    var login: String
    var avatarUrl: String // we don't have to write avatar_url, because Coders and Decoders can automatically convert snake case to camel case
    
}
