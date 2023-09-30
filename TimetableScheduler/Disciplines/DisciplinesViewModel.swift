//
//  DisciplinesViewModel.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import Foundation

protocol DisciplinesViewModeling {
    func getAllDisciplines() -> [Cell<Discipline>]
}

final class DisciplinesViewModel {
    private var state: DisciplinesState = .init()
    private let disciplinesRepository: DisciplinesRepositing
    
    init(disciplinesRepository: DisciplinesRepositing) {
        self.disciplinesRepository = disciplinesRepository
        state.disciplines = fetchAllDisciplines()
    }
    
}

extension DisciplinesViewModel {
    private func fetchAllDisciplines() -> [Cell<Discipline>]{
        return disciplinesRepository.fetchDisciplines().compactMap { discipline in
            Cell(object: discipline)
        }
    }
}

extension DisciplinesViewModel: DisciplinesViewModeling {
    func getAllDisciplines() -> [Cell<Discipline>] {
        return state.disciplines
    }
}
