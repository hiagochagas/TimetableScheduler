//
//  TimetableRepository.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 29/09/23.
//

import Foundation
import SwiftData

protocol TimetableRepositing {
    func getTimetables() -> [Timetable]
    func saveTimetables(_ timetables: [Timetable])
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
    func getTimetables() -> [Timetable] {
        let description = FetchDescriptor<Timetable>()
        let result = (try? context.fetch(description)) ?? []
        return result.filter { $0.admin?.email == loggedAdmin.email }
    }
    
    func saveTimetables(_ timetables: [Timetable]) {
        deleteAllTimetables()
        timetables.forEach {
            $0.admin = loggedAdmin
            context.insert($0)
        }
        saveContext()
    }
    
    private func deleteAllTimetables() {
        let timetables = getTimetables()
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
