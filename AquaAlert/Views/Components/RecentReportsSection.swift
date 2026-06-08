//
//  RecentReportsSection.swift
//  AquaAlert
//
//  Created by Vincent on 08/06/26.
//
import SwiftUI

struct RecentReportsSection: View {
    let reports: [ReportModel]

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Laporan Terbaru")
                    .font(.headline).fontWeight(.semibold)
                Spacer()
            }
            if reports.isEmpty {
                EmptyReportsCard()
            } else {
                ForEach(reports) { report in
                    ReportCard(report: report)
                }
            }
        }
    }
}
