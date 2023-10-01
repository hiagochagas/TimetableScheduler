//
//  ScheduleDetailSheet.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 01/10/23.
//

import SwiftUI

protocol ScheduleDetailSheetDelegate {
    func didSave(schedule: Cell<Schedule>)
    func delete(schedule: Cell<Schedule>)
}

struct ScheduleDetailSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var startTime: String = ""
    @State private var endTime: String = ""
    @State private var dayOfTheWeek: Weekdays
    @State var schedule: Cell<Schedule>
    var delegate: ScheduleDetailSheetDelegate?
    var isCreationType: Bool
    
    init(schedule: Cell<Schedule>, delegate: ScheduleDetailSheetDelegate? = nil, isCreationType: Bool) {
        self._schedule = State(initialValue: schedule)
        self.delegate = delegate
        self.isCreationType = isCreationType
        self._dayOfTheWeek = State(initialValue: schedule.object.dayOfTheWeek)
    }
    
    var body: some View {
        NavigationStack {
            contentView
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        let newSchedule = Cell(
                            id: schedule.id,
                            object: Schedule(
                                dayOfTheWeek: dayOfTheWeek ?? schedule.object.dayOfTheWeek,
                                startTime: startTime.isEmpty ? schedule.object.startTime : startTime,
                                endTime: endTime.isEmpty ? schedule.object.endTime : endTime
                            )
                        )
                        delegate?.didSave(schedule: newSchedule)
                        dismiss()
                    }.tint(.green)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }.tint(.green)
                }
            }
        }
    }
    
    private var contentView: some View {
        VStack(spacing: 16) {
            startTimeLabel
            endTimeLabel
            dayOfTheWeekSelector
            if !isCreationType {
                deleteButton
            }
        }
        .padding(.all, 20)
    }
    
    private var startTimeLabel: some View {
        HStack {
            Text("Start time: ")
            Spacer()
            TextField("\(schedule.object.startTime)", text: $startTime)
        }
    }
    
    private var endTimeLabel: some View {
        HStack {
            Text("End time: ")
            Spacer()
            TextField("\(schedule.object.endTime)", text: $endTime)
        }
    }
    
    private var dayOfTheWeekSelector: some View {
        HStack {
            Text("Day of the week: ")
            Spacer()
            Picker("Day of the week", selection: $dayOfTheWeek) {
                ForEach(Weekdays.allCases) {
                    Text($0.sectionName).tag($0)
                }
            }.tint(.green)
        }
    }
    
    private var deleteButton: some View {
        Button(action: {
            delegate?.delete(schedule: schedule)
            dismiss()
        }, label: {
            Text("Delete schedule")
                .foregroundStyle(.red)
        })
    }
}
