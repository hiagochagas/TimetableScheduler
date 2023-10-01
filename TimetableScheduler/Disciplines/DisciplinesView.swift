//
//  DisciplinesView.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 27/09/23.
//

import SwiftUI

struct DisciplinesView: View {
    private let viewModel: DisciplinesViewModeling
    
    init(viewModel: DisciplinesViewModeling) {
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
            ForEach(viewModel.getAllDisciplines()) { cell in
                let discipline = cell.object
                DisciplineDetailCell(disciplineName: discipline.name)
            }
            .listRowSeparator(.hidden)
            Color(.clear)
                .frame(height: 60)
                .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
    }
}
