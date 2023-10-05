//
//  SignUpViewModel.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 04/10/23.
//

import Foundation

final class SignUpViewModel: ObservableObject {
    @Published var state: SignUpState = .init()
    private unowned var coordinator: AppCoordinator
    private let adminRepository: AdminRepositing
    
    init(coordinator: AppCoordinator, adminRepository: AdminRepositing) {
        self.coordinator = coordinator
        self.adminRepository = adminRepository
    }
}

extension SignUpViewModel {
    func signUp() {
        if let admin = adminRepository.signUp(name: state.name, email: state.email, password: state.password) {
            coordinator.activeCoordinator = .tabBar(admin: admin)
        } else {
            presentAlert(title: "Error", message: "Something went wrong while signing up")
        }
    }
    
    private func presentAlert(title: String, message: String) {
        state.alertTitle = title
        state.alertMessage = message
        state.isPresentingAlert = true
    }
}
