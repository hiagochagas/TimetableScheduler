//
//  TimetableSchedulerApp.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 27/09/23.
//

import SwiftUI
import GoogleSignIn
import SwiftData

@main
struct TimetableSchedulerApp: App {
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(coordinator: AppCoordinator())
                .preferredColorScheme(.light)
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
                .modelContainer(for: [Admin.self])
        }
    }
}
