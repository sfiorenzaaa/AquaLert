//
//  CommunityLeaderHome.swift
//  AquaAlert
//
//  Created by Macbook on 06/06/26.
//

import SwiftUI

struct CommunityLeaderHomeView: View {
    @EnvironmentObject var authController:   AuthController
    @EnvironmentObject var reportController: ReportController
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            CommunityLeaderDashboardView()
                .tabItem { Label("Verifikasi", systemImage: "checkmark.seal.fill") }
                .tag(0)

            AllReportsView()
                .tabItem { Label("Semua Laporan", systemImage: "list.bullet.rectangle") }
                .tag(1)

            ProfileView()
                .tabItem { Label("Profil", systemImage: "person.circle.fill") }
                .tag(2)
        }
        .accentColor(.purple)
    }
}

struct CommunityLeaderDashboardView: View {
    @EnvironmentObject var reportController: ReportController
    @EnvironmentObject var authController:   AuthController

    private var needsVerification: [ReportModel] {
        reportController.completedReports
    }

    
