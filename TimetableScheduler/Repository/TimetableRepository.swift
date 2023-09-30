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
            room: .init(name: "Sala 4"),
            professor: .init(name: "Henrique Leitão"),
            schedule: .init(startTime: "10:00", endTime: "12:00")
        ), Timetable(
            weekDay: .monday,
            discipline: .init(name: "TJW"),
            room: .init(name: "Laboratório de Redes Sem Fio"),
            professor: .init(name: "Corneli"),
            schedule: .init(startTime: "7:40", endTime: "9:40")
        ), Timetable(
            weekDay: .tuesday,
            discipline: .init(name: "Administração"),
            room: .init(name: "Sala 5"),
            professor: .init(name: "Ione"),
            schedule: .init(startTime: "10:00", endTime: "12:00")
        ), Timetable(
            weekDay: .wednesday,
            discipline: .init(name: "TJW"),
            room: .init(name: "Laboratório de Redes Sem Fio"),
            professor: .init(name: "Corneli"),
            schedule: .init(startTime: "7:40", endTime: "9:40")
        ), Timetable(
            weekDay: .thursday,
            discipline: .init(name: "Compiladores"),
            room: .init(name: "Sala 4"),
            professor: .init(name: "Levi"),
            schedule: .init(startTime: "07:40", endTime: "09:40")
        ), Timetable(
            weekDay: .thursday,
            discipline: .init(name: "Administração"),
            room: .init(name: "Sala 5"),
            professor: .init(name: "Ione"),
            schedule: .init(startTime: "10:00", endTime: "12:00")
        ), Timetable(
            weekDay: .friday,
            discipline: .init(name: "APS"),
            room: .init(name: "Sala 4"),
            professor: .init(name: "Henrique Leitão"),
            schedule: .init(startTime: "07:40", endTime: "09:40")
        ), Timetable(
            weekDay: .friday,
            discipline: .init(name: "Compiladores"),
            room: .init(name: "Sala 3"),
            professor: .init(name: "Levi"),
            schedule: .init(startTime: "10:00", endTime: "12:00")
        )
        ]
    }
}
