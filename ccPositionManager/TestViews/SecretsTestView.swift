//
//  SecretsTestView.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2025-01-10.
//

import SwiftUI



struct SecretsTestView: View
{
    @State private var schwabClient : SchwabClient

    init( schwabClient: SchwabClient )
    {
        self.schwabClient = schwabClient
    }

    var body: some View
    {
        VStack
        {
            HStack
            {
                Text( "Authorization URL: " )
                TextField( "Authorization URL", text: $schwabClient.secrets.authorizationUrl )
            }
            HStack
            {
                Text( "Access Token URL: " )
                TextField( "Access Token URL", text: $schwabClient.secrets.accessTokenUrl )
            }
            HStack
            {
                Text( "App Key: " )
                TextField( "App Key", text: $schwabClient.secrets.appId )
            }
            HStack
            {
                Text( "App Secret: " )
                TextField( "App Secret", text: $schwabClient.secrets.appSecret )
            }
            HStack
            {
                Text( "Redirect URL: " )
                TextField( "Redirect URL", text: $schwabClient.secrets.redirectUrl )
            }
            HStack
            {
                Text( "Code: " )
                TextField( "Code", text: $schwabClient.secrets.code )
            }
            HStack
            {
                Text( "Session: " )
                TextField( "Session", text: $schwabClient.secrets.session )
            }
            HStack
            {
                Text( "Access Token: " )
                TextField( "Access Token", text: $schwabClient.secrets.accessToken )
            }
            HStack
            {
                Text( "Refresh Token: " )
                TextField( "Refresh Token", text: $schwabClient.secrets.refreshToken )
            }

            Button( "Save Secrets" )
            {
                print( schwabClient.secrets )
                do {
                    let data = try JSONEncoder().encode( schwabClient.secrets )
                    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let fileURL = documentsDirectory.appendingPathComponent(".secrets.json")
                    try data.write( to: fileURL )
                    print( fileURL )
                } catch {
                    print("Error saving JSON: \(error)")
                }
            }
        }
    }

}

#Preview
{
    let schwabClient = SchwabClient( secrets: getSecretsFromFile() )
    SecretsTestView( schwabClient : schwabClient )
}
