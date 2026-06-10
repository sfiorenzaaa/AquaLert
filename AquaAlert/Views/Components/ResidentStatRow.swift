//
//  ResidentStatRow.swift
//  AquaAlert
//
//  Created by Vincent on 08/06/26.
//
import SwiftUI

struct ResidentStatsRow: View {
    let total: Int
    let inProgress: Int
    let completed: Int
    let confirmed: Int

    private let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            StatCard(title: "Total",    value: "\(total)",      icon: "doc.text.fill",        color: .blue)
            StatCard(title: "Diproses", value: "\(inProgress)", icon: "clock.fill",           color: .orange)
            StatCard(title: "Selesai",  value: "\(completed)",  icon: "checkmark.circle.fill", color: .green)
            StatCard(title: "Terkonfirmasi", value: "\(confirmed)", icon: "checkmark.seal.fill", color: .purple)
        }
    }
}
