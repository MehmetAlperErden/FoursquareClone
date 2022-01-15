//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Alper Erden on 18.11.2021.
//

import UIKit
import Parse

class SignUpVC: UIViewController {
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let currentUser = PFUser.current()
        if currentUser != nil {
            performSegue(withIdentifier: "toPlacesVC", sender: nil)
        }

        // Do any additional setup after loading the view.
      /*  let parseObject = PFObject(className: "Fruits")
        parseObject["name"] = "Fruits"
        parseObject["calories"] = 100
        parseObject.saveInBackground { success, error in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                print("uploaded")
            }
        }*/
    }

    @IBAction func signInClicked(_ sender: Any) {
        if usernameText.text != "" && passwordText.text != "" {
            PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText!.text!) { user, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error!.localizedDescription )
                }else {
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                    
                }
            }
            
        }
    }
    @IBAction func signUpClicked(_ sender: Any) {
        
        if  usernameText.text != "" && passwordText.text != "" {
            let user = PFUser()
            user.username = usernameText.text
            user.password = passwordText.text
            
            user.signUpInBackground { success, error in
                if error != nil {
                    self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    //segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
            
        }else {
            makeAlert(titleInput: "Error", messageInput: "Username / Password ????")
        }
    }
    func makeAlert (titleInput: String , messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

