//
//  ViewController.swift
//  Login
//
//  Created by Neil Pineda on 10/10/15.
//  Copyright (c) 2015 CBI LLC. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class Login_View: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var email_string: String?
    var password_string: String?
    
    
    @IBAction func Sign_UP(sender: UIButton) {
        //1
        let user = PFUser()
        
        //2
        email_string = userTextField.text
        password_string = passwordTextField.text
        
        //3
        let User_Database = PFObject(className: "User_Database")
        User_Database.setObject("John", forKey: "Email")
        User_Database.setObject(1230, forKey: "Password")
        User_Database.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            if succeeded {
                println("Object Uploaded")
            } else {
                println("Error: \(error) \(error!.userInfo!)")
            }
        }
        
        
        user.signUpInBackgroundWithBlock { succeeded, error in
            if (succeeded) {
                //The registration was successful, go to the wall
               // self.performSegueWithIdentifier(self.segue1, sender: nil)

            } else if let error = error {
                //Something bad has occurred
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

