//
//  AdminRepository.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 04/10/23.
//

import Foundation
import SwiftData

protocol AdminRepositing {
    func login(email: String, password: String) -> Admin?
    func signUp(name: String, email: String, password: String) -> Admin?
}

final class AdminRepository: ObservableObject {
    private let context: ModelContext
    
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
    func login(email: String, password: String) -> Admin? {
        guard let admin = admins.first(where: { admin in
            admin.email == email && admin.password == password
        }) else {
            return nil
        }
        return admin
    }
    
    func signUp(name: String, email: String, password: String) -> Admin? {
        guard !name.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              !admins.contains(where: { $0.email == email })
        else {
            return nil
        }
        let admin = Admin(name: name, email: email, password: password)
        context.insert(admin)
        do {
            try saveContext()
        } catch {
            return nil
        }
        fetchAdmins()
        return admin
    }
    
    private func saveContext() throws {
        do {
            try context.save()
        } catch {
            throw error
        }
    }
}
