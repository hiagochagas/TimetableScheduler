//
//  TimetableRepository.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 29/09/23.
//

import Foundation
import SwiftData

protocol TimetableRepositing: CommonRepository where T == Timetable {
    func deleteAllTimetables()
}

final class TimetableRepository {
    private let context: ModelContext
    private let loggedAdmin: Admin
    
    init(context: ModelContext, loggedAdmin: Admin) {
        self.context = context
        self.loggedAdmin = loggedAdmin
    }
}

extension TimetableRepository: TimetableRepositing {
    func getAll() -> [Timetable] {
        let description = FetchDescriptor<Timetable>()
        let result = (try? context.fetch(description)) ?? []
        return result.filter { $0.admin?.email == loggedAdmin.email }
    }
    
    func addModel(model: Timetable) {
        model.admin = loggedAdmin
        context.insert(model)
        saveContext()
    }
    
    func removeModel(model: Timetable) {
        context.delete(model)
        saveContext()
    }
    
    func updateModel(model: Timetable) { 
        saveContext()
    }
    
    func deleteAllTimetables() {
        let timetables = getAll()
        timetables.forEach { context.delete($0) }
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
