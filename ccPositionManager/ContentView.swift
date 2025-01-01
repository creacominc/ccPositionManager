//
//  ContentView.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2024-12-21.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var accounts: [Account]
    @State private var workflowEnum = WorkflowEnum.allCases.first!


    var body: some View
    {

        NavigationSplitView
        {

            VStack
            {

                List
                {
                    
                    ForEach( accounts )
                    { account in
                        
                        NavigationLink
                        {
                            Text( "Item at \(account.symbol) " )
                        }
                    label:
                        {
                            Text( account.symbol )
                        }
                        
                    }
                    .onDelete(perform: deleteItems)
                    
                }
#if os(macOS)
                .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
                .toolbar {
#if os(iOS)
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
#endif
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
                .task {
                    context.insert( Account( symbol: "AAPL" ) )
                    context.insert( Account( symbol: "NVDA" ) )
                    context.insert( Account( symbol: "RKLB" ) )
                }

                HStack
                {
                    // buttons at bottom
                    Picker("Workflow", selection: $workflowEnum)
                    {
                        Text( "Sell" ).tag( WorkflowEnum.SellWF )
                        Text( "Buy" ).tag( WorkflowEnum.BuyWF )
                        Text( "Cntract" ).tag( WorkflowEnum.ContractWF )
                        Text( "Account" ).tag( WorkflowEnum.AccountWF )
                    }
                    
                }

            }

        }
        detail:
        {

            VStack {
                Button("Test")
                {
                    runTest()
                }

                Text( "\($workflowEnum.id)" )
            }

        }

    }
    
    private func addItem()
    {

        withAnimation
        {

            let newItem = Account( symbol: "NEW" )
            context.insert(newItem)

        }

    }
    
    private func deleteItems(offsets: IndexSet)
    {

        withAnimation
        {

            for index in offsets
            {

                context.delete(accounts[index])

            }

        }

    }
    
    private func runTest()
    {
        print( "\n\n\n start test" )

        let schwab = SchwabAPI(
            clientId: "TODO",
            clientSecret: "TODO",
            redirectURI: "https://127.0.0.1"
        )

        schwab.authenticate
        { result in

            switch result
            {
                case .success:
                    print("Authentication successful")
                case .failure(let error):
                    print("Authentication failed: \(error)")
            }

        }

        print( "\n end test \n\n\n" )

    }
    
}

#Preview {
    
    ContentView()
        .modelContainer(for: Account.self, inMemory: true)

}
