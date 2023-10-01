//
//  SchedulesView.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 27/09/23.
//

import SwiftUI

struct SchedulesView: View {
    @ObservedObject private var viewModel: SchedulesViewModel
    @State private var selectedSchedule: Cell<Schedule>?
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
        HeaderView(buttonType: .create, delegate: self)
            .sheet(isPresented: $isCreatingSchedule) {
                let newSchedule = Cell(
                    object: Schedule(
                        dayOfTheWeek: .monday,
                        startTime: "",
                        endTime: ""
                    )
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
            .sheet(item: $selectedSchedule) { schedule in
                openSheet(with: schedule, isCreating: false)
            }
            .listRowSeparator(.hidden)
            Color(.clear)
                .frame(height: 60)
                .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
    }
    
    private func section(for weekday: Weekdays) -> some View {
        ForEach(viewModel.getSchedules(for: weekday)) { cell in
            let schedule = cell.object
            ScheduleDetailCell(startTime: schedule.startTime, endTime: schedule.endTime)
                .onTapGesture {
                    selectedSchedule = cell
                }
        }
    }
    
    private func openSheet(with schedule: Cell<Schedule>, isCreating: Bool) -> some View {
        ScheduleDetailSheet(schedule: schedule, delegate: self, isCreationType: isCreating)
            .presentationDetents([.height(200)])
    }
}

extension SchedulesView: ScheduleDetailSheetDelegate {
    func didSave(schedule: Cell<Schedule>) {
        viewModel.saveSchedule(schedule)
    }
    
    func delete(schedule: Cell<Schedule>) {
        viewModel.deleteSchedule(schedule)
    }
}

extension SchedulesView: HeaderViewDelegate {
    func didTapButton() {
        isCreatingSchedule = true
    }
}
