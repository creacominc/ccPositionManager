//
//  SecretsTestView.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2025-01-10.
//

import SwiftUI

struct SecretsTestView: View
{
    private var schwabClient : SchwabClient = SchwabClient( accessToken: "", session: "" )

    @State private var secrets : Secrets = Secrets( clientId: "", redirectUrl: "" )

    init( schwabClient: SchwabClient )
    {
        self.schwabClient = schwabClient
    }

    var body: some View
    {
        VStack
        {
            TextField( "Client Id", text: $secrets.clientId )
            TextField( "Redirect URL", text: $secrets.redirectUrl )
            
            Button( "Save Secrets" )
            {
                
                print( secrets )
                do {
                    let data = try JSONEncoder().encode( secrets )
                    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let fileURL = documentsDirectory.appendingPathComponent(".secrets.json")
                    try data.write( to: fileURL )
                    print( fileURL )
                } catch {
                    print("Error saving JSON: \(error)")
                }
                
            }
        }
        .onAppear
        {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsDirectory.appendingPathComponent(".secrets.json")
            
            let data = try? Data( contentsOf: fileURL )
            
            do {
                secrets = try JSONDecoder().decode( Secrets.self, from: data!)
                print( "secrets: \(secrets)" )
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }

}

#Preview
{
    let schwabClient = SchwabClient( accessToken: "", session: "" )
    SecretsTestView( schwabClient : schwabClient )
}
