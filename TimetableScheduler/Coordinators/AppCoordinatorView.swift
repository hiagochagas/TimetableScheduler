//
//  AppCoordinatorView.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 04/10/23.
//

import SwiftUI

struct AppCoordinatorView: View {
    @ObservedObject private var coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        ZStack {
            switch coordinator.activeCoordinator {
            case .login:
                loginView
            case .signUp:
                signUpView
            case .tabBar:
                tabBarView
            }
        }.alert(isPresented: $coordinator.isPresentingAlert) {
            Alert(
                title: Text(coordinator.alertTitle),
                message: Text(coordinator.alertMessage)
            )
        }
    }
    
    private var loginView: some View {
        LoginView(
            viewModel: .init(
                adminRepository: AdminRepository(),
                coordinator: coordinator
            )
        )
    }
    
    private var signUpView: some View {
        VStack {
            // SignUpView
        }
    }
    
    private var tabBarView: some View {
        TabBarView()
    }
}

