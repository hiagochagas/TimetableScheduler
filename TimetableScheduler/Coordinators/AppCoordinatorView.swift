//
//  AppCoordinatorView.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 04/10/23.
//

import SwiftUI

struct AppCoordinatorView: View {
    @Environment(\.modelContext) var modelContext
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
                adminRepository: AdminRepository(context: modelContext),
                coordinator: coordinator
            )
        )
    }
    
    private var tabBarView: some View {
        TabBarView()
    }
}

