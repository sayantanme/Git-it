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
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLogin.layer.cornerRadius = 5
        btnLogin.layer.borderWidth = 1
        txtUserName.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func btnGetStarted(_ sender: UIButton) {
        guard !(txtUserName.text?.isEmpty)! else {
            self.displayAlert(title: "Error", message: "Enter a login")
            return
        }
        NetworkQueries().getSearchResults(searchTerm: txtUserName.text!) { (gitUser, error) in
            guard error.isEmpty else{
                self.displayAlert(title: "Error", message: error)
                return
            }
            print("something")
        }
    }
}

