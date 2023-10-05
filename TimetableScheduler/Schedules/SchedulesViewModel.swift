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

extension SchedulesViewModel {
    func getSchedules(for weekday: Weekdays) -> [Cell<Schedule>]{
        state.schedules.filter { $0.object.dayOfTheWeek == weekday }
    }
    
    func saveSchedule(_ schedule: Cell<Schedule>) {
        guard let index = state.schedules.firstIndex(where: { $0.id == schedule.id }) else {
            createSchedule(schedule)
            return
        }
        deleteSchedule(schedule)
        state.schedules.insert(schedule, at: index)
    }
    
    private func createSchedule(_ schedule: Cell<Schedule>) {
        state.schedules.insert(schedule, at: 0)
    }
    
    func deleteSchedule(_ schedule: Cell<Schedule>) {
        state.schedules = state.schedules.filter { $0.id != schedule.id }
    }
}
