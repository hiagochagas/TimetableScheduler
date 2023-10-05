//
//  SchedulesRepository.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import Foundation
import SwiftData

protocol SchedulesRepositing {
    func fetchSchedules() -> [Schedule]
    func addSchedule(_ schedule: Schedule)
    func deleteSchedule(_ schedule: Schedule)
    func updateSchedule(_ schedule: Schedule)
}

final class SchedulesRepository {
    private let context: ModelContext
    private let loggedAdmin: Admin
    
    init(context: ModelContext, loggedAdmin: Admin) {
        self.context = context
        self.loggedAdmin = loggedAdmin
    }
}

extension SchedulesRepository: SchedulesRepositing {
    func fetchSchedules() -> [Schedule] {
        let description = FetchDescriptor<Schedule>()
        let result = (try? context.fetch(description)) ?? []
        return result.filter { $0.admin?.email == loggedAdmin.email }
    }
    
    func addSchedule(_ schedule: Schedule) {
        schedule.admin = loggedAdmin
        context.insert(schedule)
        saveContext()
    }
    
    func deleteSchedule(_ schedule: Schedule) {
        context.delete(schedule)
        saveContext()
    }
    
    func updateSchedule(_ schedule: Schedule) {
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
