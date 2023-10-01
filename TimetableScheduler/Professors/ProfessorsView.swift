//
//  ProfessorsView.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 27/09/23.
//

import SwiftUI

struct ProfessorsView: View {
    @State private var selectedProfessor: Cell<Professor>?
    @ObservedObject private var viewModel: ProfessorsViewModel
    
    init(viewModel: ProfessorsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            topContent
            contentView
        }
    }
    
    private var topContent: some View {
        HeaderView()
    }
    
    private var contentView: some View {
        List {
            ForEach(viewModel.state.professors) { cell in
                let professor = cell.object
                let disciplines = professor.disciplines.compactMap { discipline in
                    Cell(object: discipline)
                }
                ProfessorDetailCell(
                    professorName: professor.name,
                    email: professor.email,
                    disciplines: disciplines
                )
                .onTapGesture {
                    selectedProfessor = cell
                }
            }
            .sheet(item: $selectedProfessor) { professor in
                openSheet(with: professor)
            }
            .listRowSeparator(.hidden)
        }
        .scrollContentBackground(.hidden)
    }
    
    private func openSheet(with professor: Cell<Professor>) -> some View {
        ProfessorDetailSheet(professor: professor, delegate: self)
            .presentationDetents([.height(200)])
    }
}

extension ProfessorsView: ProfessorDetailSheetDelegate {
    func didSave(professor: Cell<Professor>) {
        viewModel.saveProfessor(professor: professor)
    }
    
    func delete(professor: Cell<Professor>) {
        viewModel.delete(professor: professor)
    }
}
