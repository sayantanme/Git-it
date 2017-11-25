//
//  GitHubUser.swift
//  Git-it
//
//  Created by Sayantan Chakraborty on 24/11/17.
//  Copyright © 2017 Sayantan Chakraborty. All rights reserved.
//

import Foundation.NSURL

// Query service creates Track objects
class GitHubUser {
    
    let name: String?
    let login: String?
    let location: String?
    let followers_url: String?
    let avatar_url: String?
    let public_repos: Int?
    let public_gists: Int?
    let followers: Int?
    let updated_at: String?
    
    init(name: String?, login: String?, location: String?, followers_url: String?, avatar_url: String?, public_repos: Int?, public_gists: Int?, followers: Int?, updated_at: String?) {
        self.name = name
        self.login = login
        self.location = location
        self.followers_url = followers_url
        self.avatar_url = avatar_url
        self.public_repos = public_repos
        self.public_gists = public_gists
        self.followers = followers
        self.updated_at = updated_at
    }
    
}
