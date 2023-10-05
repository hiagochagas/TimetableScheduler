//
//  ScheduleDetailSheet.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 01/10/23.
//

import SwiftUI

protocol ScheduleDetailSheetDelegate {
    func create(schedule: Schedule)
    func delete(schedule: Schedule)
    func update(schedule: Schedule)
}

struct ScheduleDetailSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var startTime: String = ""
    @State private var endTime: String = ""
    @State private var dayOfTheWeek: Weekdays
    @State var schedule: Schedule
    var delegate: ScheduleDetailSheetDelegate?
    var isCreationType: Bool
    
    init(schedule: Schedule, delegate: ScheduleDetailSheetDelegate? = nil, isCreationType: Bool) {
        self._schedule = State(initialValue: schedule)
        self.delegate = delegate
        self.isCreationType = isCreationType
        self._dayOfTheWeek = State(initialValue: schedule.dayOfTheWeek)
    }
    
    var body: some View {
        NavigationStack {
            contentView
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        schedule.dayOfTheWeek = dayOfTheWeek 
                        schedule.startTime = startTime.isEmpty ? schedule.startTime : startTime
                        schedule.endTime = endTime.isEmpty ? schedule.endTime : endTime
                        if isCreationType {
                            delegate?.create(schedule: schedule)
                        } else {
                            delegate?.update(schedule: schedule)
                        }
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
            TextField("\(schedule.startTime)", text: $startTime)
        }
    }
    
    private var endTimeLabel: some View {
        HStack {
            Text("End time: ")
            Spacer()
            TextField("\(schedule.endTime)", text: $endTime)
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
