//
//  ProfessorsViewModel.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import Foundation

final class ProfessorsViewModel: ObservableObject {
    @Published var state: ProfessorsState = .init()
    private let professorsRepository: ProfessorsRepositing
    
    init(professorsRepository: ProfessorsRepositing) {
        self.professorsRepository = professorsRepository
        state.professors = fetchProfessors()
    }
}

extension ProfessorsViewModel {
    private func fetchProfessors() -> [Cell<Professor>] {
        return professorsRepository.fetchProfessors().compactMap { professor in
            Cell(object: professor)
        }
    }
}

extension ProfessorsViewModel {
    func saveProfessor(professor: Cell<Professor>) {
        guard let index = state.professors.firstIndex(where: { $0.id == professor.id })  else { return }
        delete(professor: professor)
        state.professors.insert(professor, at: index)
    }
    
    func delete(professor: Cell<Professor>) {
        state.professors = state.professors.filter { $0.id != professor.id }
    }
}
