//
//  LoginViewModel.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 04/10/23.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published var state: LoginState = .init()
    private let adminRepository: AdminRepositing
    private unowned var coordinator: AppCoordinator
    
    init(adminRepository: AdminRepositing, coordinator: AppCoordinator) {
        self.adminRepository = adminRepository
        self.coordinator = coordinator
    }
}

extension LoginViewModel {
    func login() {
        if adminRepository.login(email: state.email, password: state.password) {
            coordinator.activeCoordinator = .tabBar
        } else {
            coordinator.presentAlert(
                title: "Error",
                message: "Something went wrong"
            )
        }
    }
    
    func signUp() {
        coordinator.activeCoordinator = .signUp
    }
}
