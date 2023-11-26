//
//  ProfessorsRepository.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import Foundation
import SwiftData

protocol ProfessorsRepositing: CommonRepository where T == Professor { }

final class ProfessorsRepository {
    private let context: ModelContext
    private let loggedAdmin: Admin
    
    init(context: ModelContext, loggedAdmin: Admin) {
        self.context = context
        self.loggedAdmin = loggedAdmin
    }
}

extension ProfessorsRepository: ProfessorsRepositing {
    func getAll() -> [Professor] {
        let description = FetchDescriptor<Professor>()
        let result = (try? context.fetch(description)) ?? []
        return result.filter { $0.admin?.email == loggedAdmin.email }
    }
    
    func addModel(model: Professor) {
        model.admin = loggedAdmin
        context.insert(model)
        saveContext()
    }
    
    func removeModel(model: Professor) {
        context.delete(model)
        saveContext()
    }
    
    func updateModel(model: Professor) {
        saveContext()
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving in \(self)")
        }
    }
}
