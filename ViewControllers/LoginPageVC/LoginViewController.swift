//
//  LoginViewController.swift
//  ARCHIDPLY
//
//  Created by Ganesh on 26/04/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var lblVersion: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupEmailTextfields()
        setupPasswordTextfields()
        setupLoginButton()
 
        // Show app version
        self.lblVersion.text = String(describing:"App Version \(String(describing: Bundle.main.releaseVersionNumber!))(\(Bundle.main.buildVersionNumber!))")
        
        //Key board notifications..
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.shadowImage = UIColor.clear.as1ptImage()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //MARK: - Setup textfields and Login Button
    
    func setupPasswordTextfields() -> Void
    {
        
        // Apply styles to password text filed....
        passwordTextField.layer.borderColor = UIColor.init(red: 240/255.0, green: 131/255.0, blue: 48/255.0, alpha: 1).cgColor
        passwordTextField.backgroundColor = UIColor.clear
        passwordTextField.setValue(UIColor.white.withAlphaComponent(0.8), forKeyPath: "_placeholderLabel.textColor")
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 5
        // Add image to password text field...
        let passwordLeftImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 30))
        passwordLeftImage.image = #imageLiteral(resourceName: "password")
        passwordTextField.leftView = passwordLeftImage
        passwordTextField.leftViewMode = .always
        
    }
    func setupEmailTextfields() -> Void
    {
        // Apply styles to email text filed...
        emailTextField.layer.borderColor = UIColor.init(red: 240/255.0, green: 131/255.0, blue: 48/255.0, alpha: 1).cgColor
        emailTextField.backgroundColor = UIColor.clear
        emailTextField.setValue(UIColor.white.withAlphaComponent(0.8), forKeyPath: "_placeholderLabel.textColor")
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.cornerRadius = 5
        // Add image to email text field...
        let emailLeftImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        emailLeftImage.image = #imageLiteral(resourceName: "email")
        emailTextField.leftView = emailLeftImage
        emailTextField.leftViewMode = .always
        
    }
    
    func setupLoginButton() -> Void
    {
        //Apply styles to sign in button....
        btnLogin.layer.borderColor = UIColor.white.cgColor
        btnLogin.backgroundColor = UIColor.init(red: 240/255.0, green: 131/255.0, blue: 48/255.0, alpha: 1)
        btnLogin.layer.borderWidth = 1
        btnLogin.layer.cornerRadius = 5
        
    }
    
    
    //MARK: - Keyboard Notifications....
    //Moving textfileds on the keyboard when user enter the text filed.
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -100
    }
    //move the keyboard to original position.
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }

    //Dismiss keyborad on touching empty space
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
 
     @IBAction func btnLoginClicked(_ sender: UIButton)
    {
        CommonObjectClass().pushTheView(fromVC: self, toVC: HomeViewController(), withIdentifier: "HomeViewController")
        
    }
    //MARK: - Text field delegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
