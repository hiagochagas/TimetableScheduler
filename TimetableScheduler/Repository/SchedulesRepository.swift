//
//  SchedulesRepository.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import Foundation
import SwiftData

protocol SchedulesRepositing: CommonRepository where T == Schedule { }

final class SchedulesRepository {
    private let context: ModelContext
    private let loggedAdmin: Admin
    
    init(context: ModelContext, loggedAdmin: Admin) {
        self.context = context
        self.loggedAdmin = loggedAdmin
    }
}

extension SchedulesRepository: SchedulesRepositing {
    func getAll() -> [Schedule] {
        let description = FetchDescriptor<Schedule>()
        let result = (try? context.fetch(description)) ?? []
        return result.filter { $0.admin?.email == loggedAdmin.email }
    }
    
    func addModel(model: Schedule) {
        model.admin = loggedAdmin
        context.insert(model)
        saveContext()
    }
    
    func removeModel(model: Schedule) {
        context.delete(model)
        saveContext()
    }
    
    func updateModel(model: Schedule) {
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
