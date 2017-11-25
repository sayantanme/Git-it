//
//  GitUserRepos.swift
//  Git-it
//
//  Created by Sayantan Chakraborty on 25/11/17.
//  Copyright © 2017 Sayantan Chakraborty. All rights reserved.
//

import Foundation.NSURL

// Query service creates Track objects
class GitUserRepos {
    
    let name: String?
    let description: String?
    let language: String?
    
    init(name: String?, description: String?,language: String?) {
        self.name = name
        self.description = description
        self.language = language
    }
    
}

