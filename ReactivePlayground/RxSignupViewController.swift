//
//  RxSignupViewController.swift
//  ReactivePlayground
//
//  Created by Tushar Gupta on 25/05/17.
//  Copyright © 2017 Tushar Gupta. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class RxSignupViewController : UIViewController {
    
    weak var signupview: SignUpView?
    var presentationModel: RxSignupPresentationModel? 
    var disposeBag: DisposeBag = DisposeBag()
    
    init(presentationModel: RxSignupPresentationModel) {
        super.init(nibName: nil, bundle: nil)
        self.presentationModel = presentationModel
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
        signupview?.emailField.rx.text.asObservable()
            .subscribe(onNext: {self.presentationModel?.email = $0})
            .addDisposableTo(disposeBag)
        signupview?.passwordField.rx.text.asObservable()
            .subscribe(onNext: {self.presentationModel?.password = $0})
            .addDisposableTo(disposeBag)
        signupview?.repeatPasswordField.rx.text.asObservable()
            .subscribe(onNext: {self.presentationModel?.repeatPassword = $0})
            .addDisposableTo(disposeBag)
        
        presentationModel?.isEmailValid.asObservable()
            .subscribe(onNext: {self.signupview?.emailField.textColor = $0 ? UIColor.black : UIColor.lightGray})
            .addDisposableTo(disposeBag)
        presentationModel?.isPasswordValid.asObservable()
            .subscribe(onNext: {self.signupview?.passwordField.textColor = $0 ? UIColor.black : UIColor.lightGray})
            .addDisposableTo(disposeBag)
        presentationModel?.isRepeatPasswordValid.asObservable()
            .subscribe(onNext: {self.signupview?.repeatPasswordField.textColor = $0 ? UIColor.black : UIColor.lightGray})
            .addDisposableTo(disposeBag)
        presentationModel?.isSignupEnabled.asObservable()
            .subscribe(onNext: {self.signupview?.enableSignup = $0})
        .addDisposableTo(disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Reactive"
    }
}
