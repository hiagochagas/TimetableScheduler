//
//  Discipline.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 29/09/23.
//

import Foundation
import SwiftData

@Model
class Discipline: Equatable {
    @Attribute(.unique)
    var name: String
    
    @Relationship(inverse: \Admin.disciplines)
    var admin: Admin?
    
    init(name: String, admin: Admin? = nil) {
        self.name = name
        self.admin = admin
    }
}
