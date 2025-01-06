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
    @State private var selectedAccountName: String = "Select Account"

    var body: some View
    {

        VStack
        {

            Picker( "Workflow", selection: $selectedWorkflow )
            {
                ForEach( WorkflowEnum.allCases )
                { workflow in
                    Text( workflow.rawValue )
                }
            }
            .pickerStyle( .segmented )

            Picker( "Account", selection: $selectedAccountName )
            {
                ForEach( accounts )
                { account in
                    Text( account.accountNumber() )
                }
            }

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

