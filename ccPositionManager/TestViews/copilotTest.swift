import SwiftUI
import Combine

struct CopilotTestView: View
{
    @State private var authUrl = "https://api.schwabapi.com/v1/oauth/authorize?client_id=WWWWWWWWWWWWWWWWWWWWWWWWWWWWW&redirect_uri=https://127.0.0.1"
    @State private var returnedLink = ""
    @State private var code = ""
    @State private var accessToken = ""
    @State private var refreshToken = ""
    @State private var accountNumbers: [String] = []
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var result : String = "TBD"
    
    var body: some View {
        VStack {
            Text("Click to authenticate:")
            Link("Authenticate", destination: URL(string: authUrl)!)
            TextField("Paste the redirect URL here", text: $returnedLink)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("Submit") {
                handleAuth()
            }
            .padding()
            if !accountNumbers.isEmpty {
                List(accountNumbers, id: \.self) { account in
                    Text(account)
                }
            }
            Text( self.result  )
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .padding()
    }
    
    func handleAuth() {
        guard let codeRange = returnedLink.range(of: "code=") else {
            alertMessage = "Invalid redirect URL"
            showAlert = true
            return
        }
        code = String(returnedLink[codeRange.upperBound...])
        code = String(code.prefix { $0 != "&" })
        
        print( "Code = \(code)" )
        
        let appKey = "aaaaaaaaaaaaaaaaaaaaaaaaaaa"
        let appSecret = "ssssssssssssssss"
        let authString = "\(appKey):\(appSecret)"
        let authData = authString.data(using: .utf8)!
        let authHeader = "Basic \(authData.base64EncodedString())"
        
        print( "AuthHeader = \(authHeader)" )
        
        var request = URLRequest(url: URL(string: "https://api.schwabapi.com/v1/oauth/token")!)
        request.httpMethod = "POST"
        request.setValue(authHeader, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let bodyString = "grant_type=authorization_code&code=\(code)&redirect_uri=https://127.0.0.1"
        request.httpBody = bodyString.data(using: .utf8)
        
        print( "body = \(bodyString)" )
        
        URLSession.shared.dataTask(with: request)
        { data, response, error in
            guard let data = data, error == nil else {
                alertMessage = error?.localizedDescription ?? "Unknown error"
                showAlert = true
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
            {
                if let tokenDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                {
                    accessToken = tokenDict["access_token"] as? String ?? ""
                    refreshToken = tokenDict["refresh_token"] as? String ?? ""
                    print( "AccessToken = \(accessToken)" )
                    print( "RefreshToken = \(refreshToken)" )
                    fetchAccountNumbers()
                } else {
                    alertMessage = "Failed to parse token response"
                    showAlert = true
                }
            } else {
                alertMessage = "Failed to get token"
                showAlert = true
            }
        }.resume()
    }

    func fetchAccountNumbers() {
        guard !accessToken.isEmpty else { return }
        print( "In fetchAccountNumbers" )
        var request = URLRequest(url: URL(string: "https://api.schwabapi.com/trader/v1/accounts/accountNumbers")!)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        print( "AccessToken: \(accessToken)" )
        URLSession.shared.dataTask(with: request)
        { data, response, error in
            guard let data = data, error == nil else
            {
                alertMessage = error?.localizedDescription ?? "Unknown error"
                showAlert = true
                print( "error: \(String(describing: error))" )
                return
            }
            
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
            {
                do
                {
                    print( "status code == 200" )
                    print( "Error: \(String(describing: error))" )
                    let dataDecoded = Data(base64Encoded: data.base64EncodedString())!
                    print( "data decoded: \(String(describing: dataDecoded))" )
                    let dataString = String(data: dataDecoded, encoding: .utf8)
                    print( "data string: \(String(describing: dataString!))" )
                    let jobj = try JSONSerialization.jsonObject(with: dataDecoded, options: [])
                    print( "jobj =  \(jobj),  type of jobj: \(type(of: jobj))" )
                    
                    test(str: dataString ?? "[{\"name\":\"None Yet\"}]", indx: 0 )
                }
                catch
                {
                    alertMessage = error.localizedDescription
                    print( "error: \(error.localizedDescription)" )
                    showAlert = true
                }
                
                if let accountDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let accounts = accountDict["accounts"] as? [String]
                {
                    DispatchQueue.main.async {
                        accountNumbers = accounts
                    }
                }
                else
                {
                    alertMessage = "Failed to parse account response"
                    showAlert = true
                }
            }
            else
            {
                alertMessage = "Failed to fetch account numbers"
                showAlert = true
            }
            
        }.resume()
    }
    
    
    func test( str: String, indx: Int )
    {
        let data = Data(str.utf8)
        print( "Testing:: \(str)" )
        print( "Data:: \(data)")

        let decoder = JSONDecoder()
        do {
            let people = try decoder.decode([AccountInfo].self, from: data)
            print(people[0])
            print(people[1])
        } catch {
            print(error.localizedDescription)
        }
    }
    
}


struct AccountInfo : Decodable
{
    var accountNumber: String
    var hashValue: String
}


#Preview {
    CopilotTestView( )
}
