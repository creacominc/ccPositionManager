//
//  JsonTest.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2025-01-19.
//

import SwiftUI

struct JsonTest: View {
    let src : String = "[{\"id\":\"foo\",\"name\":\"John\"},{\"id\":\"bar\",\"name\":\"Jane\"}]"
    @State var data : [Any] = []
    @State var result : String = ""
    @State var index : Int  = 0
    @State var name: String = ""
    
    var body: some View {
        VStack
        {
            Text( src ).padding(10)
            Picker("Index", selection: $index  )
            {
                ForEach(0..<2)
                {
                    Text("\($0)")
                }
            }
            
            Text( index.description ).padding(10)
                .onChange(of: index)
            { newValue in
                if let jsonData = try? JSONSerialization.jsonObject(with: src.data(using: .utf8)!, options: []) as? [Any]
                {
                    self.data = jsonData
                    self.result = "\(jsonData[newValue])"
                }
                else
                {
                    self.result = "Error parsing JSON"
                }
            }

            Text( result ).padding(10)
            Text( name ).padding(10)

        }
        .padding(10)
        .onAppear
        {
            if let jsonData = try? JSONSerialization.jsonObject(with: src.data(using: .utf8)!, options: []) as? [Any]
            {
                self.data = jsonData
                self.result = "\(jsonData[self.index])"

/**
 
 */



            }
            else
            {
                self.result = "Error parsing JSON"
            }
        }
        
    }
}


#Preview {
    JsonTest()
}
