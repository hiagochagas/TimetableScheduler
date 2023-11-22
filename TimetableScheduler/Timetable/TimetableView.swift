//
//  TimetableView.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 27/09/23.
//

import SwiftUI

struct TimetableView: View {
    private let viewModel: TimetableViewModeling
    
    init(viewModel: TimetableViewModeling) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            topContent
            timetableView
        }
    }
}

// MARK: - Views
extension TimetableView {
    private var topContent: some View {
        HeaderView(admin: viewModel.admin, delegate: self)
    }
    
    private var timetableView: some View {
        List {
            ForEach(Weekdays.allCases) { weekday in
                Section(header: Text(weekday.sectionName)) {
                    section(for: weekday)
                }
            }
            .listRowSeparator(.hidden)
            Color(.clear)
                .frame(height: 60)
                .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
    }
    
    private func section(for weekday: Weekdays) -> some View{
        ForEach(viewModel.getTimetables(for: weekday)) { cell in
            let timetable = cell.object
            TimetableDetailCell(
                disciplineName: timetable.discipline.name,
                startTime: timetable.schedule?.startTime ?? "",
                endTime: timetable.schedule?.endTime ?? ""
            )
        }
    }
}

// MARK: - HeaderViewDelegate
extension TimetableView: HeaderViewDelegate {
    func didTapButton() {
        viewModel.resetTimetable()
    }
}
