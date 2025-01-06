//
//  SecurityListView.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2025-01-01.
//

import SwiftUI
import SwiftData

struct SecurityListView: View
{
    @Query private var positions: [Position]
    @Environment(\.modelContext) private var context

    var body: some View
    {

        List( positions )
        { position in
            HStack {
                Text( position.symbol() )
            }
        }

    }

}

#Preview
{
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Position.self, configurations: config)

    for i in 1..<8 {
        let position = Position(symbol: "Sym\(i)", averagePrice: Double(i) )
        container.mainContext.insert( position )
    }

    return SecurityListView()
        .modelContainer(container)

}
