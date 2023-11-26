//
//  DisciplinesRepository.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import Foundation
import SwiftData

protocol DisciplinesRepositing: CommonRepository where T == Discipline { }

final class DisciplinesRepository {
    private let context: ModelContext
    private let loggedAdmin: Admin
    
    init(context: ModelContext, loggedAdmin: Admin) {
        self.context = context
        self.loggedAdmin = loggedAdmin
    }
}

extension DisciplinesRepository: DisciplinesRepositing {
    func getAll() -> [Discipline] {
        let description = FetchDescriptor<Discipline>()
        let result = (try? context.fetch(description)) ?? []
        return result.filter { $0.admin?.email == loggedAdmin.email }
    }
    
    func addModel(model: Discipline) {
        model.admin = loggedAdmin
        context.insert(model)
        saveContext()
    }
    
    func removeModel(model: Discipline) {
        context.delete(model)
        saveContext()
    }
    
    func updateModel(model: Discipline) {
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
