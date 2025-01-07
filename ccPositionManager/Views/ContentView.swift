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
    @State private var workflowEnum = WorkflowEnum.allCases.first!


    var body: some View
    {

        NavigationSplitView
        {

            NavView()

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
    

    private func runTest()
    {
        print( "\n\n\n start test" )
//        /** @TODO:  put secrets in the env file.  */
//        let schwab = SchwabAPI(
//            clientId: "TODO",
//            clientSecret: "TODO",
//            redirectURI: "https://127.0.0.1"
//        )
//
//        schwab.authenticate
//        { result in
//
//            switch result
//            {
//                case .success:
//                    print("Authentication successful")
//                case .failure(let error):
//                    print("Authentication failed: \(error)")
//            }
//
//        }

        print( "\n end test \n\n\n" )

    }
    
}

#Preview {

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
    
    return ContentView()
        .modelContainer(container)

}
