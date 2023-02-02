//
//  ViewController.swift
//  Login
//
//  Created by David Granger on 2/2/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? UIButton else { return }
        if sender == forgotUsername {
            segue.destination.navigationItem.title = "Forgot Username"
        } else if sender == forgotPassword {
            segue.destination.navigationItem.title = "Forgot Password"
        } else {
            segue.destination.navigationItem.title = userNameTextField.text
        }
    }

    @IBOutlet var forgotUsername: UIButton!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var forgotPassword: UIButton!
    
    @IBAction func userNameTextField(_ sender: Any) {
    }
    
    @IBAction func forgotUsernameButton(_ sender: UIButton) {
        performSegue(withIdentifier: "forgotUsernameOrPassword", sender: forgotUsername)
    }
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
        performSegue(withIdentifier: "forgotUsernameOrPassword", sender: forgotPassword)
    }
}

