//
//  EmptyAdminCard.swift
//
import SwiftUI

struct EmptyAdminCard: View {
    let message: String

    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
            Text(message).font(.caption).foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}
