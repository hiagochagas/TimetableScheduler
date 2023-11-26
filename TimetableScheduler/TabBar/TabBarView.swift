//
//  TabBarView.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 27/09/23.
//

import SwiftUI
import SwiftData

struct TabBarView: View {
    @State private var tabSelected: Tab = .timetable
    private let admin: Admin
    private let repositoryFactory: RepositoryFactory
    
    init(repositoryFactory: RepositoryFactory, admin: Admin) {
        self.admin = admin
        self.repositoryFactory = repositoryFactory
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
                timetableRepository: repositoryFactory.getRepository(for: .timetable) as! (any TimetableRepositing),
                professorsRepository: repositoryFactory.getRepository(for: .professor) as! any ProfessorsRepositing,
                schedulesRepository: repositoryFactory.getRepository(for: .schedule) as! any SchedulesRepositing,
                admin: admin
            )
        )
    }
    
    private var professorsView: some View {
        ProfessorsView(
            viewModel: ProfessorsViewModel(
                professorsRepository: repositoryFactory.getRepository(for: .professor) as! (any ProfessorsRepositing),
                disciplinesRepository: repositoryFactory.getRepository(for: .discipline) as! (any DisciplinesRepositing),
                schedulesRepository: repositoryFactory.getRepository(for: .schedule) as! (any SchedulesRepositing),
                admin: admin
            )
        )
    }
    
    private var schedulesView: some View {
        SchedulesView(
            viewModel: SchedulesViewModel(
                schedulesRepository: repositoryFactory.getRepository(for: .schedule) as! (any SchedulesRepositing),
                admin: admin
            )
        )
    }
    
    private var disciplinesView: some View {
        DisciplinesView(
            viewModel: DisciplinesViewModel(
                disciplinesRepository: repositoryFactory.getRepository(for: .discipline) as! (any DisciplinesRepositing),
                admin: admin
            )
        )
    }
}
