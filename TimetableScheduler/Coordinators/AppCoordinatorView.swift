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
            case .tabBar(let admin):
                tabBarView(with: admin)
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
    
    private func tabBarView(with admin: Admin) -> some View {
        TabBarView(admin: admin)
    }
}

