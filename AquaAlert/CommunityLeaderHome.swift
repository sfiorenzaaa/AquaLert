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

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    CLHeader(userName: authController.currentUser?.name ?? "Ketua RT/RW")

                    HStack(spacing: 12) {
                        StatCard(title: "Perlu Verifikasi", value: "\(needsVerification.count)", icon: "checkmark.seal", color: .purple)
                        StatCard(title: "Total Laporan",    value: "\(reportController.reports.count)", icon: "doc.text.fill", color: .blue)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "checkmark.seal.fill").foregroundColor(.purple)
                            Text("Perlu Diverifikasi").font(.headline).fontWeight(.semibold)
                            Spacer()
                            Text("\(needsVerification.count) laporan").font(.caption).foregroundColor(.gray)
                        }

                        if needsVerification.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "checkmark.circle.fill").font(.system(size: 40)).foregroundColor(.green)
                                Text("Tidak ada laporan yang perlu diverifikasi saat ini.")
                                    .font(.caption).foregroundColor(.gray).multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        } else {
                            ForEach(needsVerification) { report in
                                NavigationLink(destination: VerifyReportView(report: report)) {
                                    CLReportCard(report: report)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 30)
            }
            .background(Color(.systemGray6).ignoresSafeArea())
            .navigationTitle("Panel Ketua RT/RW")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

