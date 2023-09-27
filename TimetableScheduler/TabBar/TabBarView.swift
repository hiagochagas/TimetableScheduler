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
            teachersView
            schedulesView
        }
    }
    
    private var timetableView: some View {
        TimetableView()
            .tabItem {
                Label("Timetable", systemImage: "clock.fill")
            }
    }
    
    private var teachersView: some View {
        TeachersView()
            .tabItem {
                Label("Teachers", systemImage: "graduationcap.fill")
            }
    }
    
    private var schedulesView: some View {
        SchedulesView()
            .tabItem {
                Label("Schedule", systemImage: "book.closed.fill")
            }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
