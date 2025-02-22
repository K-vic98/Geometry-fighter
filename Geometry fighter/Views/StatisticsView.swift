//
//  StatisticsView.swift
//  Geometry fighter
//
//  Created by Виктор Куделин on 03.02.2025.
//

import SwiftUI

struct StatisticsView: View {

    // MARK: Public properties

    let units: [StatisticsUnit]

    // MARK: View implementation

    var body: some View {
        HStack(alignment: .bottom, spacing: 32) {
            ForEach(units) { unit in
                HStack(spacing: 8) {
                    Text(unit.icon)
                    Text(unit.title)
                }
            }
        }
    }
}

#Preview {
    StatisticsView(
        units: [
            .init(icon: "❤️", title: "1"),
            .init(icon: "😎", title: "23")
        ]
    )
}
