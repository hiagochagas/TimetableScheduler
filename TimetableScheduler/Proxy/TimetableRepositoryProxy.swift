//
//  TimetableRepositoryProxy.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 26/11/23.
//

import Foundation

final class TimetableRepositoryProxy {
    private let repository: TimetableRepository
    
    init(repository: TimetableRepository) {
        self.repository = repository
        // proxy action 
        repository.deleteAllTimetables()
    }
}

extension TimetableRepositoryProxy: TimetableRepositing {
    func getAll() -> [Timetable] {
        repository.getAll()
    }
    
    func addModel(model: Timetable) {
        repository.addModel(model: model)
    }
    
    func removeModel(model: Timetable) {
        repository.removeModel(model: model)
    }
    
    func updateModel(model: Timetable) {
        repository.updateModel(model: model)
    }
    
    func deleteAllTimetables() {
        repository.deleteAllTimetables()
    }
}
