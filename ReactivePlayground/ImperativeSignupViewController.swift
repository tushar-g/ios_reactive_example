//
//  ImperativeSignupViewController.swift
//  ReactivePlayground
//
//  Created by Tushar Gupta on 24/05/17.
//  Copyright © 2017 Tushar Gupta. All rights reserved.
//

import UIKit

class ImperativeSignupViewController: UIViewController {
    
    weak var signupview: SignUpView?
    var presentationModel: ImperativeSignupPresentationModel? 
    
    init(presentationModel: ImperativeSignupPresentationModel) {
        super.init(nibName: nil, bundle: nil)
        self.presentationModel = presentationModel
        self.presentationModel?.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        if let signupview = SignUpView.loadFromNib() as? SignUpView {
            self.signupview = signupview
            self.view.addSubview(signupview)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupview?.emailField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        signupview?.passwordField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        signupview?.repeatPasswordField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Imperative"
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        if textField == signupview?.emailField {
            presentationModel?.email = textField.text
        } else if textField == signupview?.passwordField {
            presentationModel?.password = textField.text
        } else if textField == signupview?.repeatPasswordField {
            presentationModel?.repeatPassword = textField.text
        }
    }
}

extension ImperativeSignupViewController: ImperativeSignupPresentationModelDelegate {
    func isSignup(enabled: Bool) {
        signupview?.enableSignup = enabled
    }
    
    func isEmail(valid: Bool) {
        signupview?.emailField.textColor = valid ? UIColor.black : UIColor.lightGray
    }
    
    func isPassword(valid: Bool) {
        signupview?.passwordField.textColor = valid ? UIColor.black : UIColor.lightGray
    }
    
    func isRepeatPassword(valid: Bool) {
        signupview?.repeatPasswordField.textColor = valid ? UIColor.black : UIColor.lightGray
    }
}
