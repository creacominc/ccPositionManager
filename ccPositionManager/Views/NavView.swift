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

    var body: some View
    {

        VStack
        {

            WorkflowButtonsView()

            NavigationStack
            {
                SecurityListView()
            }

        }

    }

}

#Preview
{

    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Position.self, configurations: config)

    for i in 1..<10 {
        let position = Position(symbol: "Sym\(i)", averagePrice: Double(i) )
        container.mainContext.insert( position )
    }

    return NavView()
        .modelContainer(container)

}
