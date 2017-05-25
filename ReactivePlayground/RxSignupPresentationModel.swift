//
//  RxSignupPresentationModel.swift
//  ReactivePlayground
//
//  Created by Tushar Gupta on 25/05/17.
//  Copyright © 2017 Tushar Gupta. All rights reserved.
//

import Foundation
import RxSwift

class RxSignupPresentationModel {
    
    var isEmailValid = Variable<Bool>(false)
    var email: String? {
        willSet {
            isEmailValid.value = newValue?.isEmail() ?? false
        }
    }
    
    var isPasswordValid = Variable<Bool>(false)
    var password: String? {
        willSet {
            isPasswordValid.value = (newValue?.characters.count ?? -1) >= Util.VALID_PASSWORD_LENGTH
        }
    }
    
    var isRepeatPasswordValid = Variable<Bool>(false)
    var repeatPassword: String? {
        willSet {
            if let new = newValue, let pswd = password,
                isPasswordValid.value == true, new == pswd {
                isRepeatPasswordValid.value = true
            } else {
                isRepeatPasswordValid.value = false
            }
        }
    }
    
    var isSignupEnabled = Variable<Bool>(false)
    
    var disposeBag = DisposeBag()
    
    init() {
        Observable.combineLatest(isEmailValid.asObservable(), isPasswordValid.asObservable(), isRepeatPasswordValid.asObservable()) { $0 && $1 && $2 }
            .subscribe(onNext: {self.isSignupEnabled.value = $0})
            .addDisposableTo(disposeBag)
    }
}
