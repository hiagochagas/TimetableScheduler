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
    let admin: Admin
    
    init(disciplinesRepository: DisciplinesRepositing, admin: Admin) {
        self.disciplinesRepository = disciplinesRepository
        self.admin = admin
        fetchAllDisciplines()
    }
}

extension DisciplinesViewModel {
    private func fetchAllDisciplines() {
        state.disciplines = disciplinesRepository.fetchDisciplines()
    }
}

extension DisciplinesViewModel {
    func updateDiscipline(_ discipline: Discipline) {
        disciplinesRepository.updateDiscipline(discipline)
        fetchAllDisciplines()
    }
    
    func addDiscipline(_ discipline: Discipline) {
        disciplinesRepository.addDiscipline(discipline)
        fetchAllDisciplines()
    }
    
    func deleteDiscipline(_ discipline: Discipline) {
        disciplinesRepository.deleteDiscipline(discipline)
        fetchAllDisciplines()
    }
}
