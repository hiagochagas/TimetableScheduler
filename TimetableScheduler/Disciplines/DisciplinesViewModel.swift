//
//  DisciplinesViewModel.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import Foundation

final class DisciplinesViewModel: ObservableObject {
    @Published var state: DisciplinesState = .init()
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

extension DisciplinesViewModel {
    func saveDiscipline(_ discipline: Cell<Discipline>) {
        guard let index = state.disciplines.firstIndex(where: { $0.id == discipline.id }) else {
            createDiscipline(discipline)
            return
        }
        deleteDiscipline(discipline)
        state.disciplines.insert(discipline, at: index)
    }
    
    private func createDiscipline(_ discipline: Cell<Discipline>) {
        state.disciplines.insert(discipline, at: 0)
    }
    
    func deleteDiscipline(_ discipline: Cell<Discipline>) {
        state.disciplines = state.disciplines.filter { $0.id != discipline.id }
    }
}
