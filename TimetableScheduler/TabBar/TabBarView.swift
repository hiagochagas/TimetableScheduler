//
//  TabBarView.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 27/09/23.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            timetableView
            professorsView
            schedulesView
            disciplinesView
        }
    }
    
    private var timetableView: some View {
        TimetableView(
            viewModel: TimetableViewModel(
                timetableRepository: TimetableRepository()
            )
        )
        .tabItem {
            Label("Timetable", systemImage: "house")
        }
    }
    
    private var professorsView: some View {
        ProfessorsView(
            viewModel: ProfessorsViewModel(
                professorsRepository: ProfessorsRepository()
            )
        )
        .tabItem {
            Label("Professors", systemImage: "graduationcap.fill")
        }
    }
    
    private var schedulesView: some View {
        SchedulesView(
            viewModel: SchedulesViewModel(
                schedulesRepository: SchedulesRepository()
            )
        )
        .tabItem {
            Label("Schedule", systemImage: "clock.fill")
        }
    }
    
    private var disciplinesView: some View {
        DisciplinesView()
            .tabItem {
                Label("Disciplines", systemImage: "book.closed.fill")
            }
    }
}
