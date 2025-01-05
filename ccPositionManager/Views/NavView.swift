//
//  NavView.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2025-01-01.
//

import SwiftUI
import SwiftData

struct NavView: View
{

    @Query private var positions: [Position]
    @Environment(\.modelContext) private var context

    var body: some View
    {
        NavigationStack
        {
            List( positions, id: \.m_symbol )
            { position in
                HStack {
                    Text( position.m_symbol )
                }
            }
            .navigationTitle("Positions")
            .task {
                context.insert( Position( symbol: "AAPL" )  )
                context.insert( Position( symbol: "CLOV" )  )
                context.insert( Position( symbol: "RKLB" )  )
            }
        }
    }
}

#Preview
{
    NavView()
        .modelContainer(for: Position.self, inMemory: true)
}
