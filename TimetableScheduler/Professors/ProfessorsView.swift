//
//  ProfessorsView.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 27/09/23.
//

import SwiftUI

struct ProfessorsView: View {
    @State private var isCreatingProfessor: Bool = false
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
        HeaderView(buttonType: .create, delegate: self)
            .sheet(isPresented: $isCreatingProfessor) {
                let newProfessor = Cell(
                    object: Professor(
                        name: "",
                        email: "",
                        disciplines: []
                    )
                )
                openSheet(with: newProfessor, isCreating: true)
            }
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
            .listRowSeparator(.hidden)
            Color(.clear)
                .frame(height: 60)
                .listRowSeparator(.hidden)
        }
        .sheet(item: $selectedProfessor) { professor in
            openSheet(with: professor, isCreating: false)
        }
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
    }
    
    private func openSheet(with professor: Cell<Professor>, isCreating: Bool) -> some View {
        ProfessorDetailSheet(professor: professor, delegate: self, isCreationType: isCreating)
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

extension ProfessorsView: HeaderViewDelegate {
    func didTapButton() {
        isCreatingProfessor = true
    }
}
