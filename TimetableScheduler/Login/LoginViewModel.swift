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
        guard adminRepository.login(email: state.email, password: state.password) else {
            presentAlert(title: "Error", message: "Something went wrong in login")
            return
        }
        coordinator.activeCoordinator = .tabBar
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
        guard let presentingViewController = UIApplication.shared.keyWindow?.rootViewController else {
            presentAlert(title: "Error", message: "Error on Google Sign In")
            return
        }
        
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: "347248752064-l43vgdh8e8794s068i12bs4n6tasura9.apps.googleusercontent.com")
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { [weak self] signInResult, error in
            guard let self = self, error == nil, let user = signInResult?.user, let email = user.profile?.email, let password = user.userID, let name = user.profile?.givenName else {
                self?.presentAlert(title: "Error", message: "Error on Google Sign In")
                return
            }
            
            if self.adminRepository.login(email: email, password: password) || self.adminRepository.signUp(name: name, email: email, password: password) {
                self.coordinator.activeCoordinator = .tabBar
            } else {
                self.presentAlert(title: "Error", message: "Error on Google Sign In")
            }
        }
    }
}
