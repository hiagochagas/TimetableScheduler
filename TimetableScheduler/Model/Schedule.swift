//
//  Schedule.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 29/09/23.
//

import Foundation
import SwiftData

@Model
class Schedule: Equatable {
    var dayOfTheWeek: Weekdays
    var startTime: String
    var endTime: String
    
    @Relationship(inverse: \Admin.schedules)
    var admin: Admin?
    
    init(dayOfTheWeek: Weekdays, startTime: String, endTime: String, admin: Admin? = nil) {
        self.dayOfTheWeek = dayOfTheWeek
        self.startTime = startTime
        self.endTime = endTime
        self.admin = admin
    }
}
