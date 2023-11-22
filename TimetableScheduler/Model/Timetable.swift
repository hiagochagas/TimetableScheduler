//
//  Timetable.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 29/09/23.
//

import Foundation

class Timetable: Equatable {
    let discipline: Discipline
    let professor: Professor
    var schedule: Schedule?
    
    init(discipline: Discipline, professor: Professor, schedule: Schedule? = nil) {
        self.discipline = discipline
        self.professor = professor
        self.schedule = schedule
    }
    
    static func == (lhs: Timetable, rhs: Timetable) -> Bool {
        lhs.discipline == rhs.discipline && lhs.professor == rhs.professor
    }
}
