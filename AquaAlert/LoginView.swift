//
//  LoginView.swift
//  AquaAlert
//
//  Created by Macbook on 05/06/26.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showRegister = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @EnvironmentObject var authController: AuthController
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [Color.blue.opacity(0.1), Color.white],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        
                        VStack(spacing: 16) {
                            
                            ZStack {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.blue, Color.cyan],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 100, height: 100)
                                    .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 5)
                                
                                Image(systemName: "drop.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.white)
                            }
                            
                            Text("AquaAlert")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            
                            Text("Laporkan Masalah Air & Sanitasi")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 40)
                        
                        
                        VStack(spacing: 24) {
                            CustomTextField(
                                title: "Email",
                                icon: "envelope",
                                text: $email,
                                keyboardType: .emailAddress
                            )
                            
                            CustomTextField(
                                title: "Password",
                                icon: "lock",
                                text: $password,
                                isSecure: true
                            )
                        }
                        .padding(.horizontal, 24)
                        
                        
                      
