//
//  ViewController.swift
//  Git-it
//
//  Created by Sayantan Chakraborty on 24/11/17.
//  Copyright © 2017 Sayantan Chakraborty. All rights reserved.
//

import UIKit

class LoginVC: UIViewController,Notifier {
    
    @IBOutlet weak var activityindicator: UIActivityIndicatorView!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    var user:GitHubUser?
    var isConnectedToNetwork = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLogin.layer.cornerRadius = 5
        btnLogin.layer.borderWidth = 1
        txtUserName.becomeFirstResponder()
        activityindicator.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(networkTypeChangedDashBoard), name: .networkChangedFlag, object: Network.reachability)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnGetStarted(_ sender: UIButton) {
        guard !(txtUserName.text?.isEmpty)! else {
            self.displayAlert(title: "Error", message: "Enter a login")
            return
        }
        
        //Checks the network is the app is connected to the internet if it is, data is fetched over the network else from coredata
        if(!isConnectedToNetwork){
            let gitHubUser = CoreDataDA().getGitUser(username: txtUserName.text!, appDelegate: UIApplication.shared.delegate as! AppDelegate)
            if gitHubUser == nil{
                self.displayAlert(title: "Info", message: "App is offline and no user present in database")
            }else{
                self.user = gitHubUser
                performSegue(withIdentifier: "showUserDetails", sender: nil)
            }
        }else{
            activityindicator.isHidden = false
            activityindicator.startAnimating()
            NetworkQueries().fetchGithubUser(searchTerm: txtUserName.text!) { (gitUser, error) in
                guard error.isEmpty else{
                    self.displayAlert(title: "Error", message: error)
                    DispatchQueue.main.async {
                        self.activityindicator.stopAnimating()
                        self.activityindicator.isHidden = true
                    }
                    return
                }
                if let user = gitUser{
                    self.user = user
                    CoreDataDA().save(gitUser: user, appDelegate: UIApplication.shared.delegate as! AppDelegate)
                    self.performSegue(withIdentifier: "showUserDetails", sender: nil)
                }
                
                DispatchQueue.main.async {
                    self.activityindicator.stopAnimating()
                    self.activityindicator.isHidden = true
                }

            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ProfileTVC {
            let pTVC = segue.destination as! ProfileTVC
            pTVC.gitUser = user
        }
    }
    
//    fileprivate toggleActivityIndicatorState(){
//        //if
//    }
    
    /// When network status chnages this will fire
    ///
    /// - Parameter notification: notification object
    @objc func networkTypeChangedDashBoard(_ notification: NSNotification) {
        guard let status = Network.reachability?.status else { return }
        switch status {
        case .unreachable:
            isConnectedToNetwork = false
        case .wifi:
            isConnectedToNetwork = true
        case .wwan:
            isConnectedToNetwork = true
        }
    }
}

