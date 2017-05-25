//
//  ImperativeSignupPresentationModel.swift
//  ReactivePlayground
//
//  Created by Tushar Gupta on 24/05/17.
//  Copyright © 2017 Tushar Gupta. All rights reserved.
//

import Foundation

protocol ImperativeSignupPresentationModelDelegate {
    func isSignup(enabled: Bool)
    func isEmail(valid: Bool)
    func isPassword(valid: Bool)
    func isRepeatPassword(valid: Bool)
}

class ImperativeSignupPresentationModel {
    var email: String? {
        didSet {
            checkForValidity()
        }
    }
    var password: String? {
        didSet {
            checkForValidity()
        }
    }
    var repeatPassword: String? {
        didSet {
            checkForValidity()
        }
    }
    
    var delegate: ImperativeSignupPresentationModelDelegate?
    
    func checkForValidity() {
        
        var validEmail = false
        var validPassword = false
        var validRepeatPassword = false
        
        if let email = self.email, email.isEmail() {
            validEmail = true
        }
        
        if let password = self.password, password.characters.count >= Util.VALID_PASSWORD_LENGTH {
            validPassword = true
        }
        
        if let repeatPassword = self.repeatPassword, let password = self.password, repeatPassword == password, validPassword == true {
            validRepeatPassword = true
        }
        
        delegate?.isEmail(valid: validEmail)
        delegate?.isPassword(valid: validPassword)
        delegate?.isRepeatPassword(valid: validRepeatPassword)
        delegate?.isSignup(enabled: validEmail && validPassword && validRepeatPassword)
    }
}
