//
//  Timetable.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 29/09/23.
//

import Foundation
import SwiftData

@Model
final class Timetable: Equatable {
    @Relationship
    var discipline: Discipline?
    @Relationship
    var professor: Professor?
    @Relationship
    var schedule: Schedule?
    
    @Relationship(inverse: \Admin.timetables)
    var admin: Admin?
    
    init(discipline: Discipline, professor: Professor, schedule: Schedule? = nil, admin: Admin? = nil) {
        self.discipline = discipline
        self.professor = professor
        self.schedule = schedule
        self.admin = admin
    }
    
    static func == (lhs: Timetable, rhs: Timetable) -> Bool {
        lhs.discipline == rhs.discipline && lhs.professor == rhs.professor
    }
}
