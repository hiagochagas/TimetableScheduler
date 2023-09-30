//
//  ProfessorsView.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 27/09/23.
//

import SwiftUI

struct ProfessorsView: View {
    private let viewModel: ProfessorsViewModeling
    
    init(viewModel: ProfessorsViewModeling) {
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
            ForEach(viewModel.getAllProfessors()) { cell in
                let professor = cell.object
                ProfessorDetailCell(professorName: professor.name)
            }
            .listRowSeparator(.hidden)
        }
        .scrollContentBackground(.hidden)
    }
}
