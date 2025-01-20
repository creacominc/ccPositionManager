//
//  JsonTest2.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2025-01-19.
//

import SwiftUI

struct JsonTest2: View
{
    @State var result: String = "ready"
    @State var indx: Int = 0

    var body: some View
    {
        Picker( "Index", selection: $indx )
        {
            Text("1").tag(0)
            Text("2").tag(1)
            Text("3").tag(2)
        }
        .onChange(of: indx)
        { value in
            self.test2( )
        }
        Text( self.result )
            .padding( )
            .onAppear( perform: self.test2 )
    }

    func test2()
    {
        print( "in test2" )
        let jsonString = """
        [
            {
                "name": "Taylor Swift",
                "age": 26
            },
            {
                "name": "Justin Bieber",
                "age": 25
            }
        ]
        """

        let jsonData = Data(jsonString.utf8)
        //print( "jsonData: \(jsonData)" )
        let decoder = JSONDecoder()
        do {
            let people = try decoder.decode([Person].self, from: jsonData)
            print(people[0])
        } catch {
            print(error.localizedDescription)
        }

    }

    struct Person: Codable {
        var name: String
        var age: Int
    }



    func test()
    {
        print( "in test" )
        let str = "value: [{\"accountNumber\":\"010101010101\",\"hashValue\":\"123456asdfgh123456asdfgh\"}]" // "{\"names\": [\"Bob\", \"Tim\", \"Tina\"]}"
        let data = Data(str.utf8)
        print( data )

        let decoder = JSONDecoder()
        do
        {
            let account = try decoder.decode([AccountData2].self, from: data)
            print( account )
        }
        catch
        {
            print( error.localizedDescription )
        }

    }


}

struct AccountData2: Decodable {
    let accountNumber: String
    let hashValue: String
}


#Preview {
    JsonTest2()
}
