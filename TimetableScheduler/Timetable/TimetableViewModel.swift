//
//  TimetableViewModel.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 29/09/23.
//

import Foundation

protocol TimetableViewModeling {
    func getTimetables(for weekday: Weekdays) -> [Cell<Timetable>]
}

final class TimetableViewModel {
    private let timetableRepository: TimetableRepositing
    var state: TimetableState = .init()
    
    init(timetableRepository: TimetableRepositing) {
        self.timetableRepository = timetableRepository
        state.timetables = getAllTimetables()
    }
}

extension TimetableViewModel {
    private func getAllTimetables() -> [Cell<Timetable>]{
        return timetableRepository.getTimetables().compactMap { timetable in
            Cell(object: timetable)
        }
    }
}

extension TimetableViewModel: TimetableViewModeling {
    func getTimetables(for weekday: Weekdays) -> [Cell<Timetable>] {
        state.timetables.filter { $0.object.weekDay == weekday }
    }
}

