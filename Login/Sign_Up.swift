//
//  Sign_Up.swift
//  Login
//
//  Created by Neil Pineda on 10/10/15.
//  Copyright (c) 2015 CBI LLC. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

var verify_email: String?
var objectID_string: String?

class Sign_Up: UIViewController {
    
    
    @IBOutlet weak var First_Name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Retype_Password: UITextField!
    
    var first_name: String?
    var email_string: String?
    var password_string: String!
    var retype_password: String?
    
    
    
    var password_length: Int?
    
    @IBAction func Sign_Up_Button(sender: AnyObject) {
        
        first_name = First_Name.text
        email_string = Email.text
        password_string = Password.text
        retype_password = Retype_Password.text
        
        //Acceptance tests
        //1.  User needs to meet password criteria *** Working
        password_length = count(password_string)
        if password_length < 5 || password_length > 16 {
            displayError("Password must be between 6-15 characters.")
            return
        }
        
        //2.  User needs to have password and retype password the same *** Working
        if password_string != retype_password {
            displayError("Passwords do not match.")
            return
        }
        
        //3.  Make sure all fields are filled *** Working
        if First_Name.text == "" || Email.text == "" || Password.text == "" || Retype_Password.text == ""{
            displayError("Please fill in all fields")
            return
        }
        
        //4. Redundancy Check for emails within database.
        
        let query = PFQuery(className: "New_User")
        query.whereKey("Email", equalTo: email_string!)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil && objects!.count != 0{
                self.displayError("Email already exists")
                return
                
            } else {
                
                let User = PFObject(className: "New_User")
                User.setObject(self.first_name!, forKey: "First_Name")
                User.setObject(self.email_string!, forKey: "Email")
                User.setObject(self.password_string!, forKey: "Password")
                User.saveInBackgroundWithBlock { (succeeded, error) -> Void in
                    if succeeded {
                        println("Object Uploaded")
                    }
                    else {
                    }
                }
            }
        }
    }
    
    func displayError(errorMessage: String!)-> Void{
        let alert = UIAlertView()
        alert.title = "Error"
        alert.message = errorMessage
        alert.addButtonWithTitle("Ok")
        alert.show()
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