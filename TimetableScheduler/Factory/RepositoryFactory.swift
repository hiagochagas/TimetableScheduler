//
//  RepositoryFactory.swift
//  TimetableScheduler
//
//  Created by PremierSoft on 26/11/23.
//

import Foundation
import SwiftData

enum RepositoryType {
    case professor
    case discipline
    case schedule
    case timetable
}

final class RepositoryFactory {
    private var repositories: [RepositoryType: any CommonRepository] = [:]
    private let modelContext: ModelContext
    private let loggedAdmin: Admin
    
    init(modelContext: ModelContext, loggedAdmin: Admin) {
        self.modelContext = modelContext
        self.loggedAdmin = loggedAdmin
    }
    
    func getRepository(for type: RepositoryType) -> any CommonRepository {
        if let repository = repositories[type] {
            return repository
        }
        var repository: any CommonRepository
        switch type {
        case .professor:
            repository = ProfessorsRepository(context: modelContext, loggedAdmin: loggedAdmin)
        case .discipline:
            repository = DisciplinesRepository(context: modelContext, loggedAdmin: loggedAdmin)
        case .schedule:
            repository = SchedulesRepository(context: modelContext, loggedAdmin: loggedAdmin)
        case .timetable:
            repository = TimetableRepository(context: modelContext, loggedAdmin: loggedAdmin)
        }
        repositories[type] = repository
        return repository
    }
}
