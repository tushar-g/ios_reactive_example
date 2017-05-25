//
//  SIgnUpView.swift
//  ReactivePlayground
//
//  Created by Tushar Gupta on 24/05/17.
//  Copyright © 2017 Tushar Gupta. All rights reserved.
//

import UIKit

class SignUpView: UIView {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    var enableSignup = false {
        willSet {
            if newValue {
                signupButton.isEnabled = true
                signupButton.layer.borderColor = UIColor.black.cgColor
            } else {
                signupButton.isEnabled = false
                signupButton.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        passwordField.isSecureTextEntry = true
        
        repeatPasswordField.isSecureTextEntry = true
        
        signupButton.setTitleColor(UIColor.lightGray, for: .disabled)
        signupButton.setTitleColor(UIColor.black, for: .normal)
        signupButton.isEnabled = false
        signupButton.layer.borderColor = UIColor.lightGray.cgColor
        signupButton.layer.borderWidth = 1
        signupButton.layer.cornerRadius = 6
    }
}
