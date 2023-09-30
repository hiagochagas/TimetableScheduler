//
//  SchedulesViewModel.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import Foundation

protocol SchedulesViewModeling {
    func getAllSchedules() -> [Cell<Schedule>]
}

final class SchedulesViewModel {
    private var state: SchedulesState = .init()
    private let schedulesRepository: SchedulesRepositing
    
    init(schedulesRepository: SchedulesRepositing) {
        self.schedulesRepository = schedulesRepository
        state.schedules = fetchAllSchedules()
    }
    
}

extension SchedulesViewModel {
    private func fetchAllSchedules() -> [Cell<Schedule>]{
        return schedulesRepository.fetchSchedules().compactMap { schedule in
            Cell(object: schedule)
        }
    }
}

extension SchedulesViewModel: SchedulesViewModeling {
    func getAllSchedules() -> [Cell<Schedule>] {
        return state.schedules
    }
}


