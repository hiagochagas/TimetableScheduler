//
//  TimetableViewModel.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 29/09/23.
//

import Foundation

protocol TimetableViewModeling {
    var admin: Admin { get }
    func getTimetables(for weekday: Weekdays) -> [Cell<Timetable>]
    func resetTimetable()
}

final class TimetableViewModel {
    private let timetableRepository: TimetableRepositing
    private let professorsRepository: ProfessorsRepositing
    private let schedulesRepository: SchedulesRepositing
    @Published var state: TimetableState = .init()
    var admin: Admin
    
    init(
        timetableRepository: TimetableRepositing,
        professorsRepository: ProfessorsRepositing,
        schedulesRepository: SchedulesRepositing,
        admin: Admin
    ) {
        self.timetableRepository = timetableRepository
        self.professorsRepository = professorsRepository
        self.schedulesRepository = schedulesRepository
        self.admin = admin
        state.timetables = getAllTimetables()
    }
}

extension TimetableViewModel {
    private func getAllTimetables() -> [Cell<Timetable>]{
        return timetableRepository.getTimetables().compactMap { timetable in
            Cell(object: timetable)
        }
    }
    
    private func createTimetables(professors: [Professor]) -> [Timetable] {
        var timetables: [Timetable] = []
        for professor in professors {
            for discipline in professor.disciplines {
                timetables.append(
                    .init(discipline: discipline, professor: professor, schedule: nil)
                )
            }
        }
        return timetables
    }
    
    private func createGraph(timetables: [Timetable]) -> [[Int]] {
        var graph = [[Int]](repeating: [Int](repeating: 0, count: timetables.count), count: timetables.count)
        for (i, t1) in timetables.enumerated() {
            for (j, t2) in timetables.enumerated() {
                if i == j || i > j {
                    continue
                }
                if t1.professor == t2.professor || t1.discipline.name == t2.discipline.name || t1.discipline.semester == t2.discipline.semester {
                    graph[i][j] = 1
                    graph[j][i] = 1
                }
            }
        }
        return graph
    }
    
    private func findAdjacentTimetables(graph: [[Int]], timetables: [Timetable], t: Timetable) -> [Timetable] {
        guard let timetableIndex = timetables.firstIndex(where: { $0 == t }) else { return [] }
        var adjacents: [Timetable] = []
        for (index, adjacency) in graph[timetableIndex].enumerated() {
            if adjacency == 1 {
                adjacents.append(timetables[index])
            }
        }
        return adjacents
    }
    
    private func colorTimetable(_ timetable: Timetable, graph: [[Int]], timetables: [Timetable], schedules: [Schedule]) {
        let adjacentTimetables = findAdjacentTimetables(graph: graph, timetables: timetables, t: timetable)
        var adjacentSchedules: Set<Schedule> = []
        for adjacentTimetable in adjacentTimetables {
            if let schedule = adjacentTimetable.schedule {
                adjacentSchedules.insert(schedule)
            }
        }
        for preferredSchedule in timetable.professor.preferredSchedules {
            if !adjacentSchedules.contains(preferredSchedule) {
                timetable.schedule = preferredSchedule
                break
            }
        }
        guard timetable.schedule == nil else { return }
        for schedule in schedules {
            if !adjacentSchedules.contains(schedule) {
                timetable.schedule = schedule
                break
            }
        }
    }
    
    private func orderTimetablesByVertexGrade(graph: [[Int]], timetables: [Timetable]) -> [Timetable] {
        var result: [(Timetable, Int)] = []
        for (index, t) in timetables.enumerated() {
            let vertexGrade = graph[index].filter { $0 == 1 }.count
            result.append((t, vertexGrade))
        }
        result.sort { $0.1 > $1.1 }
        return result.map { $0.0 }
    }
    
    private func nandalAlgorithm(graph: [[Int]], timetables: [Timetable], schedules: [Schedule]) -> [Timetable] {
        let orderedTimetables = orderTimetablesByVertexGrade(graph: graph, timetables: timetables)
        for timetable in orderedTimetables {
            colorTimetable(timetable, graph: graph, timetables: timetables, schedules: schedules)
        }
        return orderedTimetables
    }
    
    private func allocateTimetables() -> [Timetable] {
        let schedules = schedulesRepository.fetchSchedules()
        let professors = professorsRepository.fetchProfessors()
        let timetables = createTimetables(professors: professors)
        let graph = createGraph(timetables: timetables)
        return nandalAlgorithm(graph: graph, timetables: timetables, schedules: schedules)
    }
}

extension TimetableViewModel: TimetableViewModeling {
    func getTimetables(for weekday: Weekdays) -> [Cell<Timetable>] {
        state.timetables.filter { $0.object.schedule?.dayOfTheWeek == weekday }
    }
    
    func resetTimetable() {
        timetableRepository.saveTimetables(allocateTimetables())
        state.timetables = getAllTimetables()
    }
}

