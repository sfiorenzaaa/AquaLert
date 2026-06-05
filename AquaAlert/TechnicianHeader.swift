//
//  TechnicianHeader.swift
//  AquaAlert
//
//  Created by Macbook on 05/06/26.
//

import SwiftUI

struct TechnicianHeader: View {
    let userName: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Halo, Teknisi 👋").font(.subheadline).foregroundColor(.gray)
                Text(userName).font(.title2).fontWeight(.bold)
                Text("Kerjakan laporan yang telah di-assign ke Anda").font(.caption).foregroundColor(.green)
            }
            Spacer()
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [.green, .teal], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 55, height: 55)
                Image(systemName: "wrench.fill").font(.title2).foregroundColor(.white)
            }
        }
        .padding(.top, 16)
    }
}

