//
//  FoundationExtensions.swift
//  ReactivePlayground
//
//  Created by Tushar Gupta on 24/05/17.
//  Copyright © 2017 Tushar Gupta. All rights reserved.
//

import Foundation

extension String {
    func isEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
