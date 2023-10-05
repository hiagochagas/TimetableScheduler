//
//  ProfessorsRepository.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import Foundation
import SwiftData

protocol ProfessorsRepositing {
    func fetchProfessors() -> [Professor]
    func addProfessor(_ professor: Professor)
    func deleteProfessor(_ professor: Professor)
    func updateProfessor(_ professor: Professor)
}

final class ProfessorsRepository {
    private let context: ModelContext
    private let loggedAdmin: Admin
    
    init(context: ModelContext, loggedAdmin: Admin) {
        self.context = context
        self.loggedAdmin = loggedAdmin
    }
}

extension ProfessorsRepository: ProfessorsRepositing {
    func fetchProfessors() -> [Professor] {
        let description = FetchDescriptor<Professor>()
        let result = (try? context.fetch(description)) ?? []
        return result.filter { $0.admin?.email == loggedAdmin.email }
    }
    
    func addProfessor(_ professor: Professor) {
        professor.admin = loggedAdmin
        context.insert(professor)
        saveContext()
    }
    
    func deleteProfessor(_ professor: Professor) {
        context.delete(professor)
        saveContext()
    }
    
    func updateProfessor(_ professor: Professor) {
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
