//
//  Professor.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 29/09/23.
//

import Foundation
import SwiftData

@Model
class Professor: Equatable {
    var name: String
    @Attribute(.unique)
    var email: String
    @Relationship(inverse: \Admin.professors)
    var admin: Admin?
    @Relationship
    var disciplines: [Discipline]
    @Relationship
    var preferredSchedules: [Schedule]
    
    init(name: String, email: String, disciplines: [Discipline], preferredSchedules: [Schedule] = []) {
        self.name = name
        self.email = email
        self.disciplines = disciplines
        self.preferredSchedules = preferredSchedules
    }
}
