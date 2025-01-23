//
//  Secrets.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2025-01-10.
//

import Foundation

struct Secrets: Codable
{
    init()
    {
        authorizationUrl    = ""
        accessTokenUrl      = ""
        appId               = ""
        appSecret           = ""
        redirectUrl         = ""
        code                = ""
        session             = ""
        accessToken         = ""
        refreshToken        = ""
        accountNumbers      = []
        accountHashes       = []
    }

    var authorizationUrl    : String
    var accessTokenUrl      : String
    var appId               : String
    var appSecret           : String
    var redirectUrl         : String
    var code                : String
    var session             : String
    var accessToken         : String
    var refreshToken        : String
    var accountNumbers      : [String]
    var accountHashes       : [String]
}

func getSecretsFromFile() -> Secrets
{
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = documentsDirectory.appendingPathComponent(".secrets.json")
    
    let data = try? Data( contentsOf: fileURL )
    var secrets : Secrets = Secrets()
    do {
        secrets = try JSONDecoder().decode( Secrets.self, from: data!)
        //print( "secrets: \(secrets)" )
    } catch {
        print("getSecretsFromFile: Error decoding JSON: \(error)")
    }
    return secrets
}


