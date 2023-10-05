//
//  TimetableRepository.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 29/09/23.
//

import Foundation

protocol TimetableRepositing {
    func getTimetables() -> [Timetable]
}

final class TimetableRepository {
    
}

extension TimetableRepository: TimetableRepositing {
    func getTimetables() -> [Timetable] {
        [Timetable(
            weekDay: .monday,
            discipline: .init(name: "APS"),
            room: .init(name: "Sala 4", capacity: 50, disciplines: []),
            professor: .init(name: "Henrique Leitão", email: ""),
            schedule: .init(dayOfTheWeek: .monday, startTime: "10:00", endTime: "12:00")
        ), Timetable(
            weekDay: .monday,
            discipline: .init(name: "TJW"),
            room: .init(name: "Laboratório de Redes Sem Fio", capacity: 50, disciplines: []),
            professor: .init(name: "Corneli", email: ""),
            schedule: .init(dayOfTheWeek: .monday, startTime: "7:40", endTime: "9:40")
        ), Timetable(
            weekDay: .tuesday,
            discipline: .init(name: "Administração"),
            room: .init(name: "Sala 5", capacity: 50, disciplines: []),
            professor: .init(name: "Ione", email: ""),
            schedule: .init(dayOfTheWeek: .tuesday, startTime: "10:00", endTime: "12:00")
        ), Timetable(
            weekDay: .wednesday,
            discipline: .init(name: "TJW"),
            room: .init(name: "Laboratório de Redes Sem Fio", capacity: 50, disciplines: []),
            professor: .init(name: "Corneli", email: ""),
            schedule: .init(dayOfTheWeek: .wednesday, startTime: "7:40", endTime: "9:40")
        ), Timetable(
            weekDay: .thursday,
            discipline: .init(name: "Compiladores"),
            room: .init(name: "Sala 4", capacity: 50, disciplines: []),
            professor: .init(name: "Levi", email: ""),
            schedule: .init(dayOfTheWeek: .thursday, startTime: "07:40", endTime: "09:40")
        ), Timetable(
            weekDay: .thursday,
            discipline: .init(name: "Administração"),
            room: .init(name: "Sala 5", capacity: 50, disciplines: []),
            professor: .init(name: "Ione", email: ""),
            schedule: .init(dayOfTheWeek: .thursday, startTime: "10:00", endTime: "12:00")
        ), Timetable(
            weekDay: .friday,
            discipline: .init(name: "APS"),
            room: .init(name: "Sala 4", capacity: 50, disciplines: []),
            professor: .init(name: "Henrique Leitão", email: ""),
            schedule: .init(dayOfTheWeek: .friday, startTime: "07:40", endTime: "09:40")
        ), Timetable(
            weekDay: .friday,
            discipline: .init(name: "Compiladores"),
            room: .init(name: "Sala 3", capacity: 50, disciplines: []),
            professor: .init(name: "Levi", email: ""),
            schedule: .init(dayOfTheWeek: .friday, startTime: "10:00", endTime: "12:00")
        )
        ]
    }
}
