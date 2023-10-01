//
//  TabBarView.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 27/09/23.
//

import SwiftUI

struct TabBarView: View {
    @State private var tabSelected: Tab = .timetable
        
    init() {
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
                timetableRepository: TimetableRepository()
            )
        )
    }
    
    private var professorsView: some View {
        ProfessorsView(
            viewModel: ProfessorsViewModel(
                professorsRepository: ProfessorsRepository()
            )
        )
    }
    
    private var schedulesView: some View {
        SchedulesView(
            viewModel: SchedulesViewModel(
                schedulesRepository: SchedulesRepository()
            )
        )
    }
    
    private var disciplinesView: some View {
        DisciplinesView(
            viewModel: DisciplinesViewModel(
                disciplinesRepository: DisciplinesRepository()
            )
        )
    }
}
