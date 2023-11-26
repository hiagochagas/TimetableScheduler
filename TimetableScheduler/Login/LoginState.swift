//
//  LoginState.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 04/10/23.
//

import Foundation

struct LoginState {
    var email: String = ""
    var password: String = ""
    var isPresentingSignUp = false
    var isPresentingAlert = false
    var alertTitle: String = ""
    var alertMessage: String = ""
}
