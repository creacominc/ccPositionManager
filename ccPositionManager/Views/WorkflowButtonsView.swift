//
//  WorkflowButtonsView.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2025-01-05.
//

import SwiftUI
import SwiftData

struct WorkflowButtonsView: View
{

    @Query private var accounts: [Account]
    @Environment(\.modelContext) private var context

    @State private var selectedWorkflow: String = ""
    @State private var selectedAccountName: String = ""

    var body: some View
    {

        VStack
        {
            let pickerValues : [String] = WorkflowEnum.allCases.map(\.rawValue)

            Picker( "", selection: $selectedWorkflow )
            {

                Text( WorkflowEnum.allCases[ 0 ].rawValue ).tag( WorkflowEnum.allCases[ 0 ].rawValue )
                Text( WorkflowEnum.allCases[ 1 ].rawValue ).tag( WorkflowEnum.allCases[ 1 ].rawValue )
                Text( WorkflowEnum.allCases[ 2 ].rawValue ).tag( WorkflowEnum.allCases[ 2 ].rawValue )
                Text( WorkflowEnum.allCases[ 3 ].rawValue ).tag( WorkflowEnum.allCases[ 3 ].rawValue )

            }
            .pickerStyle( .segmented )
            .onAppear { selectedWorkflow = WorkflowEnum.allCases.first?.rawValue ?? "Sell" }
            .onAppear {             print( WorkflowEnum.allCases ) }
            .onAppear { print( pickerValues ) }
            .onAppear { print( pickerValues.indices ) }

            Picker( "", selection: $selectedAccountName )
            {
                Text( "All" ).tag( "All" )

                ForEach( accounts )
                { account in
                    Text( account.accountNumber() ).tag( account.accountNumber() )
                }
            }
            .pickerStyle( .menu )
            .onAppear { selectedAccountName = "All" }

        }

    }
    
}

#Preview
{

    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Account.self, configurations: config)

    for i in 1..<5 {
        let account = Account( accountNumber: "10\(i)" )
        container.mainContext.insert( account )
    }

    return WorkflowButtonsView()
        .modelContainer(container)

}

