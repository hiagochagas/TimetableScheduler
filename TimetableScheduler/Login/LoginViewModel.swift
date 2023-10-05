//
//  LoginViewModel.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 04/10/23.
//

import Foundation
import GoogleSignIn

final class LoginViewModel: ObservableObject {
    @Published var state: LoginState = .init()
    private let adminRepository: AdminRepositing
    unowned var coordinator: AppCoordinator
    
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
            presentAlert(
                title: "Error",
                message: "Something went wrong in login"
            )
        }
    }
    
    func signUp() {
        state.isPresentingSignUp = true
    }
    
    private func presentAlert(title: String, message: String) {
        state.alertTitle = title
        state.alertMessage = message
        state.isPresentingAlert = true
    }
    
    func googleLogin() {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {
            presentAlert(title: "Error", message: "Error on Google Sign In")
            return
        }
        
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: "347248752064-l43vgdh8e8794s068i12bs4n6tasura9.apps.googleusercontent.com")
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { [weak self] signInResult, error in
            guard let self,
                  error == nil,
                  let user = signInResult?.user,
                  let email = user.profile?.email,
                  let password = user.userID,
                  let name = user.profile?.givenName
            else {
                self?.presentAlert(title: "Error", message: "Error on Google Sign In")
                return
            }
            if adminRepository.login(email: email, password: password) {
                coordinator.activeCoordinator = .tabBar
            } else if adminRepository.signUp(name: name, email: email, password: password) {
                coordinator.activeCoordinator = .tabBar
            } else {
                presentAlert(title: "Error", message: "Error on Google Sign In")
            }
        }
    }
}
