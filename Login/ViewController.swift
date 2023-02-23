//
//  ViewController.swift
//  Login
//
//  Created by David Granger on 2/2/23.
//

import UIKit

var dataToPass: String = ""

extension UIStackView {
    func customize(backgroundColor: UIColor = .clear, radiusSize: CGFloat = 0) {
        let subView = UIView(frame: CGRect(x: -20, y: 0, width: 300, height: 250))
        subView.backgroundColor = backgroundColor
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)

        subView.layer.cornerRadius = radiusSize
        subView.layer.masksToBounds = true
        subView.clipsToBounds = true
    }
}

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    func isValidPassword() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$")
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    func containsDigit(_ value: String) -> Bool {
        let regularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: value)
    }
    
    func containsLowerCase(_ value: String) -> Bool {
        let regularExpression = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: value)
    }
    
    var howManyTimesEyeButtonPressed: Int = 0
    @IBAction func eyeButton(_ sender: Any) {
        howManyTimesEyeButtonPressed += 1
        
        if howManyTimesEyeButtonPressed % 2 == 0 {
            passwordBox.isSecureTextEntry = true
        } else {
            passwordBox.isSecureTextEntry = false
        }
    }
    func containsUpperCase(_ value: String) -> Bool {
        let regularExpression = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: value)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.customize(backgroundColor: UIColor(red: 1, green: 191/255, blue: 20/255, alpha: 0.85), radiusSize: 15)
        userNameTextField.delegate = self
        passwordBox.delegate = self
        forgotPassword.isHidden = true
        forgotUsername.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? UIButton else { return }
        
        if sender == forgotUsername {
            dataToPass = "Forgot Username Page"
            segue.destination.navigationItem.title = "Forgot Username Page"
            segue.destination.view.backgroundColor = .red
        } else if sender == forgotPassword {
            dataToPass = "Forgot Password Page"
            segue.destination.navigationItem.title = "Forgot Password Page"
            segue.destination.view.backgroundColor = .red
        } else {
            dataToPass = "Success"
            segue.destination.navigationItem.title = "Success"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBOutlet weak var passwordBox: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet var forgotUsername: UIButton!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet var forgotPassword: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func emailTF(_ sender: UITextField) {
        if let email = userNameTextField.text {
            if !email.isValidEmail() {
                emailErrorLabel.text = "Invalid Email"
            } else {
                emailErrorLabel.text = " "
            }
        }
    }
    
    func checkIfValidLogin() -> Bool {
        if passwordErrorLabel.text == " " && emailErrorLabel.text == " " {
            return true
        } else {
            return false
        }
    }
    

    @IBAction func passwordTF(_ sender: UITextField) {
        if let password = passwordBox.text {
            if password.count < 8 {
                passwordErrorLabel.text = "Password length must be greater than 8"
            } else if !containsDigit(password) {
                passwordErrorLabel.text = "Must contain at least one digit"
            } else if !containsLowerCase(password) {
                passwordErrorLabel.text = "Must contain one lowercase letter"
            } else if !containsUpperCase(password) {
                passwordErrorLabel.text = "Must contain one uppercase letter"
            } else if !password.isValidPassword() {
                passwordErrorLabel.text = "Must contain at least one special character"
            } else {
                passwordErrorLabel.text = " "
            }
        }
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        if checkIfValidLogin() {
            performSegue(withIdentifier: "forgotUsernameOrPassword", sender: loginButton)
        }
    }
    
    @IBAction func forgotUsernameButton(_ sender: UIButton) {
        performSegue(withIdentifier: "forgotUsernameOrPassword", sender: forgotUsername)
    }
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
        performSegue(withIdentifier: "forgotUsernameOrPassword", sender: forgotPassword)
    }
}

