//
//  AppCoordinator.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 04/10/23.
//

import Foundation

final class AppCoordinator: ObservableObject {
    @Published var activeCoordinator: Coordinator = .login
}
