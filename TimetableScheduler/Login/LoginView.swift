//
//  LoginView.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 04/10/23.
//

import SwiftUI
import GoogleSignInSwift

struct LoginView: View {
    @Environment(\.modelContext) var modelContext
    @ObservedObject private var viewModel: LoginViewModel
    @State private var showFieldContent: Bool = false
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        contentView
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
            .frame(height: 140)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
    
    private var contentView: some View {
        VStack(spacing: 32) {
            logo
            fields
            buttons
        }
        .fullScreenCover(isPresented: $viewModel.state.isPresentingSignUp) {
            SignUpView(
                viewModel: .init(
                    coordinator: viewModel.coordinator,
                    adminRepository: AdminRepository(context: modelContext)
                )
            )
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
    
    private var buttons: some View {
        VStack(spacing: 8) {
            loginButton
            divider
            VStack(spacing: 16) {
                googleButton
                signUpButton
            }
        }
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
            HStack {
                secureField
                Spacer()
                Image(systemName: showFieldContent ? "eye.fill": "eye.slash.fill")
                    .renderingMode(.template)
                    .onTapGesture {
                        showFieldContent.toggle()
                    }
                    .foregroundColor(.black)
                    .padding(.trailing, 14)
            }
        }
    }
    
    private var secureField: some View {
        ZStack {
            let placeholder = "Enter your password"
            TextField(placeholder, text: $viewModel.state.password)
                .opacity(showFieldContent ? 1 : 0)
            SecureField(placeholder, text: $viewModel.state.password)
                .opacity(showFieldContent ? 0 : 1)
        }
        .animation(.none, value: showFieldContent)
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
        HStack {
            line
            Text("or").foregroundStyle(.gray)
            line
        }
    }
    
    var line: some View {
        VStack { Divider() }.padding(20)
    }
    
    private var googleButton: some View {
        HStack {
            GoogleSignInButton {
                viewModel.googleLogin()
            }
        }.frame(width: 100)
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
