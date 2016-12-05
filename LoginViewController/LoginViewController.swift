//
//  LoginViewController.swift
//  iOSTest
//
//  Created by Toseefhusen Khilji on 24/11/16.
//  Copyright © 2016 Toseef Khilji. All rights reserved.
//

import UIKit


//Extenstion of String for email validation 
extension String {
    func isValidEmail() -> Bool {
        
        // create regX for email varification
        let emailRegex = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        // Evaluate given string with prdict
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}



class LoginViewController: UIViewController,UITextFieldDelegate  {
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    // Textfields Login/paswword
    @IBOutlet weak var txtUserName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        // set rightview in password textfiled
        let btnForgotPassword : UIButton = UIButton(type: .custom)
        btnForgotPassword.setTitle("Forgot Password", for: .normal)
        btnForgotPassword.titleLabel?.font = UIFont.init(name: "Montserrat-Regular", size: 13)
        btnForgotPassword.setTitleColor(UIColor.lightGray, for: .normal)
        btnForgotPassword.setTitleColor(UIColor.white, for: .highlighted)
        btnForgotPassword.sizeToFit()
        
        // enable rightview
        self.txtPassword.rightView = btnForgotPassword;
        self.txtPassword.rightViewMode = .always
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - TextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Validate the email field
        if (textField == self.txtUserName) {
            self.validateEmailTextFieldWithText(email: textField.text)
        }
        
        // When pressing return, move to the next field
        let nextTag = textField.tag + 1
        if let nextResponder = textField.superview?.viewWithTag(nextTag) as UIResponder! {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == self.txtUserName) {
            
            // Get latest string from textfield
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            
            // Validate email
            self.validateEmailTextFieldWithText(email: newString)
        }
        return true
    }
    
    // Validation for email
    func validateEmailTextFieldWithText(email: String?) {
        if let email = email {
            if(email.characters.count == 0) {
                self.txtUserName.errorMessage = nil
            }
            else if(!isValidEmail(str: email)) {
                self.txtUserName.errorMessage = "Invalid username"
            } else {
                self.txtUserName.errorMessage = nil
            }
        } else {
            self.txtUserName.errorMessage = nil
        }
    }
    
    func isValidEmail(str:String?) -> Bool {
        
        //Validate Email
        return (str?.isValidEmail())!
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        
        // Check email validation
        if isValidEmail(str: self.txtUserName.text!) {
            
            // Trim whitespaces form password
            let strPass = self.txtPassword.text?.trimmingCharacters(in: .whitespaces)
            
            if (strPass?.characters.count)! > 0 {
                self.showNextScreen()
            }
            else{
                self.showInvalidCredentialMessage(message: "Please enter valid password.")
            }
        }
        else{
            self.showInvalidCredentialMessage(message: "Please enter valid email.")
        }
    }
    
    func showInvalidCredentialMessage(message : String) {
        
        // Create Alert messgae
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        
        // Create alert action
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        
        // Show alert message
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // Show chat screen
    func showNextScreen(){
        
        
    }
    
    // hide keyboard
    @IBAction func closeKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
}
