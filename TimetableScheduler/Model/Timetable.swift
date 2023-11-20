//
//  Timetable.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 29/09/23.
//

import Foundation

struct Timetable: Equatable {
    let weekDay: Weekdays
    let discipline: Discipline
    let professor: Professor
    let schedule: Schedule
}
