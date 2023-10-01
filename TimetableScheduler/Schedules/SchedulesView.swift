//
//  SchedulesView.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 27/09/23.
//

import SwiftUI

struct SchedulesView: View {
    private let viewModel: SchedulesViewModeling
    
    init(viewModel: SchedulesViewModeling) {
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
            ForEach(viewModel.getAllSchedules()) { cell in
                let schedule = cell.object
                ScheduleDetailCell(startTime: schedule.startTime, endTime: schedule.endTime)
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
