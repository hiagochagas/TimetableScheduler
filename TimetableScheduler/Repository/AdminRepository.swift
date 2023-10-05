//
//  AdminRepository.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 04/10/23.
//

import Foundation
import SwiftData

protocol AdminRepositing {
    func login(email: String, password: String) -> Bool
    func signUp(name: String, email: String, password: String) -> Bool
}

final class AdminRepository: ObservableObject {
    @Published var loggedAdmin: Admin?
    private let context: ModelContext
//    static let shared = AdminRepository()
    
    init(context: ModelContext) {
        self.context = context
        fetchAdmins()
    }
    
    private var admins: [Admin] = []
    
    private func fetchAdmins() {
        let description = FetchDescriptor<Admin>()
        admins = (try? context.fetch(description)) ?? []
    }
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
        context.insert(admin)
        do {
            try saveContext()
        } catch {
            return false
        }
        fetchAdmins()
        return true
    }
    
    private func saveContext() throws {
        do {
            try context.save()
        } catch {
            throw error
        }
    }
}
