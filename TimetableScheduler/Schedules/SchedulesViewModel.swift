//
//  SchedulesViewModel.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import Foundation

final class SchedulesViewModel: ObservableObject {
    @Published var state: SchedulesState = .init()
    private let schedulesRepository: SchedulesRepositing
    let admin: Admin
    
    init(schedulesRepository: SchedulesRepositing, admin: Admin) {
        self.schedulesRepository = schedulesRepository
        self.admin = admin
        fetchAllSchedules()
    }
    
}

extension SchedulesViewModel {
    private func fetchAllSchedules(){
        state.schedules = schedulesRepository.fetchSchedules()
    }
}

extension SchedulesViewModel {
    func getSchedules(for weekday: Weekdays) -> [Schedule]{
        state.schedules.filter { $0.dayOfTheWeek == weekday }
    }
    
    func updateSchedule(_ schedule: Schedule) {
        schedulesRepository.updateSchedule(schedule)
        fetchAllSchedules()
    }
    
    func addSchedule(_ schedule: Schedule) {
        schedulesRepository.addSchedule(schedule)
        fetchAllSchedules()
    }
    
    func deleteSchedule(_ schedule: Schedule) {
        schedulesRepository.deleteSchedule(schedule)
        fetchAllSchedules()
    }
}
