//
//  AdminRepository.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 04/10/23.
//

import Foundation

protocol AdminRepositing {
    func login(email: String, password: String) -> Bool
    func signUp(name: String, email: String, password: String) -> Bool
}

final class AdminRepository: ObservableObject {
    @Published var loggedAdmin: Admin?
    
    static let shared = AdminRepository()
    
    private init() {}
    
    private var admins: [Admin] = [
        .init(
            name: "Instituto Federal do Ceará",
            email: "admin@ifce.edu.br",
            password: "123456")
    ]
}

extension AdminRepository: AdminRepositing {
    func login(email: String, password: String) -> Bool {
        guard let admin = admins.first(where: { admin in
            admin.email == email && admin.password == password
        }) else {
            loggedAdmin = nil
            return false
        }
        loggedAdmin = admin
        return true
    }
    
    func signUp(name: String, email: String, password: String) -> Bool {
        guard !name.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              !admins.contains(where: { $0.email == email })
        else {
            loggedAdmin = nil
            return false
        }
        let admin = Admin(name: name, email: email, password: password)
        admins.append(admin)
        loggedAdmin = admin
        return true
    }
    
}
