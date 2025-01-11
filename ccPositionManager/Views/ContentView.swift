//
//  ContentView.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2024-12-21.
//

import SwiftUI
import SwiftData
//import Foundation
//import AuthenticationServices

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @State private var workflowEnum = WorkflowEnum.allCases.first!
    @State private var testButtonTitle: String = "Test"
    @State private var testButtonEnabled: Bool = true
    @State private var authenticateButtonEnabled: Bool = false
    @State private var authenticateButtonTitle: String = "Authenticate on Web"
    @State private var authenticateButtonUrl: URL = URL(string: "https://127.0.0.1")!

    var body: some View
    {

        NavigationSplitView
        {

            NavView()

        }
        detail:
        {

            VStack {
                Button( testButtonTitle )
                {
                    runTest()
//                    let apiClient = APIClient()
//                    testButtonTitle = "pressed"
//                    apiClient.authenticate
//                    { (result : Result< URL, APIError>) in
//
//                        switch result
//                        {
//                            case .success( let url ):
//                                print( "authenticated" )
//                                testButtonEnabled = false
//                                authenticateButtonEnabled = true
//                                authenticateButtonTitle = "Authenticated"
//                                authenticateButtonUrl = url
//                            case .failure(let error):
//                                print("Authentication failed: \(error)")
//                        }
//
//                    }
                }
                .disabled( !testButtonEnabled )


                Link( authenticateButtonTitle, destination: authenticateButtonUrl )
                    .disabled( !authenticateButtonEnabled )
                    .opacity( !authenticateButtonEnabled ? 0 : 1 )

                Text( "\($workflowEnum.id)" )
            }

        }

    }
    

    private func runTest()
    {
        print( "\n\n\n start test" )
        /** @TODO:  put secrets in the env file.  */
        @Environment(\.openURL) var openURL

        let apiClient = APIClient()
        testButtonTitle = "pressed"
        apiClient.authenticate
        { (result : Result< URL, APIError>) in

            switch result
            {
                case .success( let url ):
                    print( "authenticated" )
                    testButtonEnabled = false
                    authenticateButtonEnabled = true
                    authenticateButtonTitle = "Authenticated"
                    authenticateButtonUrl = url
                    openURL( url )
                case .failure(let error):
                    print("Authentication failed: \(error)")
            }

        }
        
//        let apiClient = APIClient()
//
//        apiClient.authenticate
//        { (result : Result< URL, APIError>) in
//
//            switch result
//            {
//                case .success:
//                    print("Authentication successful")
//                print( )
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
