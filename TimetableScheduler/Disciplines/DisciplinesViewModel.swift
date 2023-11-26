//
//  DisciplinesViewModel.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import Foundation

final class DisciplinesViewModel: ObservableObject {
    @Published var state: DisciplinesState = .init()
    private let disciplinesRepository: any DisciplinesRepositing
    let admin: Admin
    
    init(disciplinesRepository: any DisciplinesRepositing, admin: Admin) {
        self.disciplinesRepository = disciplinesRepository
        self.admin = admin
        fetchAllDisciplines()
    }
}

extension DisciplinesViewModel {
    private func fetchAllDisciplines() {
        state.disciplines = disciplinesRepository.getAll()
    }
}

extension DisciplinesViewModel {
    func updateDiscipline(_ discipline: Discipline) {
        disciplinesRepository.updateModel(model: discipline)
        fetchAllDisciplines()
    }
    
    func addDiscipline(_ discipline: Discipline) {
        disciplinesRepository.addModel(model: discipline)
        fetchAllDisciplines()
    }
    
    func deleteDiscipline(_ discipline: Discipline) {
        disciplinesRepository.removeModel(model: discipline)
        fetchAllDisciplines()
    }
}
