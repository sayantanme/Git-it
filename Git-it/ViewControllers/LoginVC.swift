//
//  ViewController.swift
//  Git-it
//
//  Created by Sayantan Chakraborty on 24/11/17.
//  Copyright © 2017 Sayantan Chakraborty. All rights reserved.
//

import UIKit

class LoginVC: UIViewController,Notifier {
    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    var user:GitHubUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLogin.layer.cornerRadius = 5
        btnLogin.layer.borderWidth = 1
        txtUserName.becomeFirstResponder()
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
        
        let gitHubUser = CoreDataDA().getGitUser(username: txtUserName.text!, appDelegate: UIApplication.shared.delegate as! AppDelegate)
        
        if gitHubUser == nil{
            NetworkQueries().fetchGithubUser(searchTerm: txtUserName.text!) { (gitUser, error) in
                guard error.isEmpty else{
                    self.displayAlert(title: "Error", message: error)
                    return
                }
                if let user = gitUser{
                    self.user = user
                    CoreDataDA().save(gitUser: user, appDelegate: UIApplication.shared.delegate as! AppDelegate)
                    self.performSegue(withIdentifier: "showUserDetails", sender: nil)
                }
            }
        }else{
            self.user = gitHubUser
            performSegue(withIdentifier: "showUserDetails", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ProfileTVC {
            let pTVC = segue.destination as! ProfileTVC
            pTVC.gitUser = user
        }
    }
}

