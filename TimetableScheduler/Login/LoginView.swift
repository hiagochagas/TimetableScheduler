//
//  LoginView.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 04/10/23.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        contentView
    }
    
    private var backgroundShadow: some View {
        RoundedRectangle(cornerRadius: 8.0)
            .fill(Color.white)
            .frame(height: 140)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
    
    private var contentView: some View {
        VStack(spacing: 16) {
            logo
            fields
            loginButton
            divider
    //        googleButton
            signUpButton
        }
    }
    
    private var logo: some View {
        Text("Timetable Scheduler")
            .font(.title)
    }
    
    private var fields: some View {
        ZStack {
            backgroundShadow
            VStack(spacing: 16) {
                emailField
                passwordField
            }
            .padding(.all, 16)
        }
        .padding(.horizontal, 20)
    }
    
    private var emailField: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Email")
                Spacer()
            }
            TextField("Enter your email", text: $viewModel.state.email)
        }
    }
    
    private var passwordField: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Password")
                Spacer()
            }
            TextField("Enter your password", text: $viewModel.state.password)
        }
    }
    
    private var loginButton: some View {
        Button {
            viewModel.login()
        } label: {
            Text("Login")
                .foregroundStyle(.green)
        }
    }
    
    private var divider: some View {
        Divider()
            .padding(.horizontal, 20)
    }
    
    private var signUpButton: some View {
        Button {
            viewModel.signUp()
        } label: {
            Text("Sign Up")
                .foregroundStyle(.green)
        }
    }
}
