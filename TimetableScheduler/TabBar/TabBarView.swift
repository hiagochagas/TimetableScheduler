//
//  TabBarView.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 27/09/23.
//

import SwiftUI

struct TabBarView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var tabSelected: Tab = .timetable
    private let admin: Admin
    
    init(admin: Admin) {
        self.admin = admin
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
            ZStack {
                VStack {
                    TabView(selection: $tabSelected) {
                        ForEach(Tab.allCases, id: \.rawValue) { tab in
                            HStack {
                                switch tab {
                                case .timetable:
                                    timetableView
                                case .professors:
                                    professorsView
                                case .schedule:
                                    schedulesView
                                case .disciplines:
                                    disciplinesView
                                }
                            }
                            .tag(tab)
                        }
                    }
                }
                VStack {
                    Spacer()
                    CustomTabBar(selectedTab: $tabSelected)
                }
            }
        }
    
    private var timetableView: some View {
        TimetableView(
            viewModel: TimetableViewModel(
                timetableRepository: TimetableRepository(),
                admin: admin
            )
        )
    }
    
    private var professorsView: some View {
        ProfessorsView(
            viewModel: ProfessorsViewModel(
                professorsRepository: ProfessorsRepository(
                    context: modelContext,
                    loggedAdmin: admin
                ),
                admin: admin
            )
        )
    }
    
    private var schedulesView: some View {
        SchedulesView(
            viewModel: SchedulesViewModel(
                schedulesRepository: SchedulesRepository(
                    context: modelContext,
                    loggedAdmin: admin),
                admin: admin
            )
        )
    }
    
    private var disciplinesView: some View {
        DisciplinesView(
            viewModel: DisciplinesViewModel(
                disciplinesRepository: DisciplinesRepository(
                    context: modelContext,
                    loggedAdmin: admin
                ),
                admin: admin
            )
        )
    }
}
