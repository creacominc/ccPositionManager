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

    let positionConfig = ModelConfiguration(isStoredInMemoryOnly: true)
    let accountConfig = ModelConfiguration(isStoredInMemoryOnly: true)
    var container : ModelContainer
    do
    {
        container = try ModelContainer(
            for: Position.self, Account.self
            , configurations: positionConfig, accountConfig
        )
    }
    catch
    {
        fatalError("Failed to configure SwiftData container.")
    }
    
    for i in 1..<10
    {
        let position = Position(symbol: "Sym\(i)", averagePrice: Double(i) )
        container.mainContext.insert( position )
        let account = Account(accountNumber: "100\(i)")
        container.mainContext.insert( account )
    }

    return NavView()
        .modelContainer(container)
    
}
