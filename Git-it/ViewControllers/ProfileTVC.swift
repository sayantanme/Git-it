//
//  ProfileTVC.swift
//  Git-it
//
//  Created by Sayantan Chakraborty on 24/11/17.
//  Copyright © 2017 Sayantan Chakraborty. All rights reserved.
//

import UIKit

class ProfileTVC: UITableViewController {

    var gitUser:GitHubUser?
    var repositories = [GitUserRepos]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Profile"
        //doExtraSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("HeaderViewCell", owner: self, options: nil)?.first as! HeaderViewCell
        //let headerCell = tableView.dequeueReusableCell(withIdentifier: "profileheadercell") as! ProfileViewCell
        headerView.followers.text = "\(gitUser?.followers ?? 0)"
        headerView.publicGists.text = "\(gitUser?.public_gists ?? 0)"
        headerView.publicRepos.text = "\(gitUser?.public_repos ?? 0)"
        headerView.lblLocation.text = gitUser?.location ?? "Unknown"
        if let imgUrl = gitUser?.avatar_url{
            headerView.imgProfile.loadImageFromImageUrlFromCache(url: imgUrl)
        }
        //headerView.addSubview(headerCell)
        return headerView
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) as! RepoDetailsCell
        var key = ""
        var value = ""
        
        switch indexPath.row {
        case 0:
            key = "Name"
            value = gitUser?.name ?? ""
            
        case 1:
            key = "Login Name"
            value = gitUser?.login ?? ""
            
        case 2:
            key = "Updated at"
            var newDate = ""
            if let dt = gitUser?.updated_at {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                //dateFormatter.dateStyle = .medium
                let date = dateFormatter.date(from: dt.components(separatedBy: "T").first! )
                dateFormatter.dateFormat = "MMM d, yyyy"
                newDate = dateFormatter.string(from: date!)
            }
            value = newDate
        default:
            key = ""
            value = ""
        }
        cell.descriptionText.text = key
        cell.detailsText.text = value

        return cell
    }
    
}

extension ProfileTVC: Notifier {
    fileprivate func doExtraSetup(){
        
        
        NetworkQueries().fetchGithubUserRepos(searchTerm: (gitUser?.login)!) { (repos, error) in
            guard error.isEmpty else{
                self.displayAlert(title: "Error", message: error)
                return
            }
            guard let repositories = repos else {
                return
            }
            DispatchQueue.main.async {
                self.repositories = repositories
                self.tableView.reloadData()
            }
        }
    
    }
}
