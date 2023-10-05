//
//  SchedulesView.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 27/09/23.
//

import SwiftUI

struct SchedulesView: View {
    @ObservedObject private var viewModel: SchedulesViewModel
    @State private var selectedSchedule: Schedule?
    @State private var isCreatingSchedule = false
    
    init(viewModel: SchedulesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            topContent
            contentView
        }
    }
    
    private var topContent: some View {
        HeaderView(admin: viewModel.admin, buttonType: .create, delegate: self)
            .sheet(isPresented: $isCreatingSchedule) {
                let newSchedule = Schedule(
                    dayOfTheWeek: .monday,
                    startTime: "",
                    endTime: ""
                )
                openSheet(with: newSchedule, isCreating: true)
            }
    }
    
    private var contentView: some View {
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
        .sheet(item: $selectedSchedule) { schedule in
            openSheet(with: schedule, isCreating: false)
        }
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
    }
    
    private func section(for weekday: Weekdays) -> some View {
        ForEach(viewModel.getSchedules(for: weekday)) { schedule in
            ScheduleDetailCell(startTime: schedule.startTime, endTime: schedule.endTime)
                .onTapGesture {
                    selectedSchedule = schedule
                }
        }
    }
    
    private func openSheet(with schedule: Schedule, isCreating: Bool) -> some View {
        ScheduleDetailSheet(schedule: schedule, delegate: self, isCreationType: isCreating)
            .presentationDetents([.height(200)])
    }
}

extension SchedulesView: ScheduleDetailSheetDelegate {
    func create(schedule: Schedule) {
        viewModel.addSchedule(schedule)
    }
    
    func delete(schedule: Schedule) {
        viewModel.deleteSchedule(schedule)
    }
    
    func update(schedule: Schedule) {
        viewModel.updateSchedule(schedule)
    }
}

extension SchedulesView: HeaderViewDelegate {
    func didTapButton() {
        isCreatingSchedule = true
    }
}
