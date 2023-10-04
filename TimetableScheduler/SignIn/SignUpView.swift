//
//  SignUpView.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 04/10/23.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var viewModel: SignUpViewModel
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            contentView
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .scaleEffect(1.5)
                    .tint(.green)
                    .padding(.leading, 16)
            }
        }
        .alert(isPresented: $viewModel.state.isPresentingAlert) {
            Alert(
                title: Text(viewModel.state.alertTitle),
                message: Text(viewModel.state.alertMessage)
            )
        }
    }
    
    private var backgroundShadow: some View {
        RoundedRectangle(cornerRadius: 8.0)
            .fill(Color.white)
            .frame(height: 200)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
    
    private var contentView: some View {
        VStack(spacing: 16) {
            Spacer()
            logo
            fields
            signUpButton
            Spacer()
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
                nameField
                emailField
                passwordField
            }
            .padding(.all, 16)
        }
        .padding(.horizontal, 20)
    }
    
    private var nameField: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Institution name")
                Spacer()
            }
            TextField("Enter your institution name", text: $viewModel.state.name)
        }
    }
    
    private var emailField: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Email")
                Spacer()
            }
            TextField("Enter your institution email", text: $viewModel.state.email)
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
    
    private var signUpButton: some View {
        Button {
            viewModel.signUp()
        } label: {
            Text("Sign Up")
                .foregroundStyle(.green)
        }
    }
}
