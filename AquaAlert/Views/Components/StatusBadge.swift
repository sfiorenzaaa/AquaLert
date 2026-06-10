//
//  StatusBadge.swift
//  AquaAlert
//
//  Created by Macbook on 06/06/26.
//

import SwiftUI

struct StatusBadge: View {
    let status: String

    var color: Color {
        switch status {
        case "Pending":     return .orange
        case "Verified":    return .blue
        case "In Progress": return .green
        case "Completed":   return Color(red: 0.2, green: 0.6, blue: 0.2)
        case "Confirmed":   return .purple
        case "Rejected":    return .red
        default:            return .gray
        }
    }

    var displayName: String {
        switch status {
        case "Pending":     return "Menunggu"
        case "Verified":    return "Diverifikasi"
        case "In Progress": return "Dikerjakan"
        case "Completed":   return "Selesai"
        case "Confirmed":   return "Terkonfirmasi"
        case "Rejected":    return "Ditolak"
        default:            return status
        }
    }

    var body: some View {
        Text(displayName)
            .font(.caption2).fontWeight(.semibold)
            .padding(.horizontal, 8).padding(.vertical, 3)
            .background(color.opacity(0.15))
            .foregroundColor(color)
            .cornerRadius(8)
    }
}
