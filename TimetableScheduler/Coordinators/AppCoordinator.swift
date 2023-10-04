//
//  AppCoordinator.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 04/10/23.
//

import Foundation

final class AppCoordinator: ObservableObject {
    @Published var activeCoordinator: Coordinator = .login
    @Published var isPresentingAlert = false
    var alertTitle: String = ""
    var alertMessage: String = ""
    
    
    func presentAlert(title: String, message: String) {
        self.alertTitle = title
        self.alertMessage = message
        isPresentingAlert = true
    }
}
