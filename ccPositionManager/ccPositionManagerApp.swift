//
//  ccPositionManagerApp.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2024-12-21.
//

import SwiftUI
import SwiftData

@main
struct ccPositionManagerApp: App
{

    private var schwabClient : SchwabClient = SchwabClient( secrets: getSecretsFromFile() )



    //    var sharedModelContainer: ModelContainer =
    //    {
    //        let schema = Schema([
    //            Account.self,
    //        ])
    //        let modelConfiguration = ModelConfiguration( schema: schema, isStoredInMemoryOnly: false )
    //
    //        do
    //        {
    //            return try ModelContainer( for: schema, configurations: [modelConfiguration] )
    //        }
    //        catch
    //        {
    //            fatalError("Could not create ModelContainer: \(error)")
    //        }
    //    }()
    //
    //    var body: some Scene
    //    {
    //        WindowGroup
    //        {
    //            ContentView()
    //        }
    //        .modelContainer(sharedModelContainer)
    //    }

    var body: some Scene
    {
        WindowGroup
        {
            //ContentView( schwabClient: schwabClient )
            CopilotTestView( )

        }
        .modelContainer( for: Position.self )
    }




}
