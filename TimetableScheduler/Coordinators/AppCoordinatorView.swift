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
            case .tabBar:
                tabBarView
            }
        }
    }
    
    private var loginView: some View {
        LoginView(
            viewModel: .init(
                adminRepository: AdminRepository.shared,
                coordinator: coordinator
            )
        )
    }
    
    private var tabBarView: some View {
        TabBarView()
    }
}

