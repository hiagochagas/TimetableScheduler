//
//  DisciplinesRepository.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import Foundation
import SwiftData

protocol DisciplinesRepositing {
    func fetchDisciplines() -> [Discipline]
    func addDiscipline(_ discipline: Discipline)
    func deleteDiscipline(_ discipline: Discipline)
    func updateDiscipline(_ discipline: Discipline)
}

final class DisciplinesRepository {
    private let context: ModelContext
    private let loggedAdmin: Admin
    
    init(context: ModelContext, loggedAdmin: Admin) {
        self.context = context
        self.loggedAdmin = loggedAdmin
    }
}

extension DisciplinesRepository: DisciplinesRepositing {
    func fetchDisciplines() -> [Discipline] {
        let description = FetchDescriptor<Discipline>()
        let result = (try? context.fetch(description)) ?? []
        return result.filter { $0.admin?.email == loggedAdmin.email }
    }
    
    func addDiscipline(_ discipline: Discipline) {
        discipline.admin = loggedAdmin
        context.insert(discipline)
        saveContext()
    }
    
    func deleteDiscipline(_ discipline: Discipline) {
        context.delete(discipline)
        saveContext()
    }
    
    func updateDiscipline(_ discipline: Discipline) {
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
