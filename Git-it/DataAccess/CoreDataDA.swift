//
//  CoreDataDA.swift
//  Git-it
//
//  Created by Sayantan Chakraborty on 25/11/17.
//  Copyright © 2017 Sayantan Chakraborty. All rights reserved.
//

import Foundation
import CoreData

class CoreDataDA {
    
    ///saves the Git User to the table
    func save(gitUser: GitHubUser, appDelegate: AppDelegate) {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "GitUser",
                                       in: managedContext)!
        
        let user = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        user.setValue(gitUser.name, forKey: "name")
        user.setValue(gitUser.login, forKey: "login")
        user.setValue(gitUser.avatar_url, forKey: "avatarUrl")
        user.setValue(gitUser.followers, forKey: "followers")
        user.setValue(gitUser.followers_url, forKey: "followersUrl")
        user.setValue(gitUser.location, forKey: "location")
        user.setValue(gitUser.public_gists, forKey: "publicGists")
        user.setValue(gitUser.public_repos, forKey: "public_repos")
        user.setValue(gitUser.updated_at, forKey: "updatedAt")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    ///fetches the git user from the database
    func getGitUser(username:String,appDelegate: AppDelegate) -> GitHubUser?{
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GitUser")
        fetchRequest.predicate = NSPredicate(format: "login ==[c] %@", username)
        
        do {
            let records = try managedContext.fetch(fetchRequest)
            if records.count > 0{
                let user = records.first as! GitUser
                return gitToGitHubUser(user: user)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    fileprivate func gitToGitHubUser(user:GitUser)->GitHubUser{
        return GitHubUser(name: user.name, login: user.login, location: user.location, followers_url: user.followersUrl, avatar_url: user.avatarUrl, public_repos: Int(user.public_repos), public_gists: Int(user.publicGists), followers: Int(user.followers), updated_at: user.updatedAt)
    }
}
