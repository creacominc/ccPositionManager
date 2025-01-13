
import Foundation
import AuthenticationServices

class SchwabClient
{
    private let AUTORIZE_WEB : String = "https://api.schwabapi.com/v1/oauth/authorize"
    private var secrets: Secrets = Secrets( clientId: "" , redirectUrl: "" )
    private var accessToken: String = ""
    private var session: String = ""

    init( accessToken: String, session: String )
    {
        self.accessToken = accessToken
        self.session = session

        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(".secrets.json")

        let data = try? Data( contentsOf: fileURL )
        
        do {
            self.secrets = try JSONDecoder().decode( Secrets.self, from: data!)
            print( "secrets: \( self.secrets )" )
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }


    func setAccessToken(accessToken: String)
    {
        self.accessToken = accessToken
    }

    func setSession(session: String)
    {
        self.session = session
    }

    func getAccessToken() -> String
    {
        return self.accessToken
    }

    func getSession() -> String
    {
        return self.session
    }


    func authenticate(completion: @escaping (Result<URL, ErrorCodes>) -> Void)
    {
        // provide the URL for authentication.
        let AUTHORIZE_URL : String  = "\(self.AUTORIZE_WEB)?response_type=code&client_id=\(self.secrets.clientId)&scope=readonly&redirect_uri=\(self.secrets.redirectUrl)"
        guard let url = URL( string: AUTHORIZE_URL ) else {
            completion(.failure(.invalidResponse))
            return
        }
        completion( .success( url ) )
        return
    }



    /**



     QuoteRequest{
     description:
     Request one or more quote data in POST body

     cusips    [
     example: List [ 808524680, 594918104 ]
     List of cusip, max of 500 of symbols+cusip+ssids

     [...]]
     fields    string
     example: quote,reference
     comma separated list of nodes in each quote
     possible values are quote,fundamental,reference,extended,regular. Dont send this attribute for full response.

     ssids    [
     example: List [ 1516105793, 34621523 ]
     List of Schwab securityid[SSID], max of 500 of symbols+cusip+ssids

     integer($int64)
     maximum: 9999999999
     minimum: 1]
     symbols    [
     example: List [ "MRAD", "EATOF", "EBIZ", "AAPL", "BAC", "AAAHX", "AAAIX", "$DJI", "$SPX", "MVEN", "SOBS", "TOITF", "CNSWF", "AMZN 230317C01360000", "DJX 231215C00290000", "/ESH23", "./ADUF23C0.55", "AUD/CAD" ]
     List of symbols, max of 500 of symbols+cusip+ssids

     string]
     realtime    boolean
     example: true
     Get realtime quotes and skip entitlement check

     Enum:
     [ true, false ]
     indicative    boolean
     example: true
     Include indicative symbol quotes for all ETF symbols in request. If ETF symbol ABC is in request and indicative=true API will return quotes for ABC and its corresponding indicative quote for $ABC.IV

     Enum:
     [ true, false ]
     }
     */
    func getQuotes(symbolId: String, completion: @escaping (Result<QuotesResponse, ErrorCodes>) -> Void)
    {
        /**
         curl -X 'GET' \
           'https://api.schwabapi.com/marketdata/v1/quotes?symbols=RY&indicative=false' \
           -H 'accept: application/json' \
           -H 'Authorization: Bearer I0.b2F1dGgyLmNkYy5zY2h3YWIuY29t.mYmRJoFgxpBZAPPWHcJpzmJH5wlW1DItYhe_mGtk5A0@'

         https://api.schwabapi.com/marketdata/v1/quotes?symbols=AAPL&indicative=false
         https://api.schwabapi.com/marketdata/v1/quotes?symbols=NVDA&indicative=false
         */
        let urlString : String = "https://api.schwabapi.com/marketdata/v1/quotes?symbols=\(symbolId)&indicative=false"
        guard let url = URL( string: urlString ) else {
            completion( .failure( .invalidResponse ) )
            return
        }
        print( url )


        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(self.accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue( "application/json", forHTTPHeaderField: "accept" )

        print( "Bearer \(self.accessToken)" )

        self.performRequest(request, completion: completion)

    }


    // {symbol_id}/quotes
    // chains (option chains)
    // expirationchains
    // pricehistory
    // movers/{symbol_id}
    // markets
    // markets/{market_id}
    // instruments
    // instruments/{cusip_id}

    // accounts/accountNumbers
    // accounts
    // accounts/{accountNumber}
    // accounts/{accountNumber}/orders - get orders
    // accounts/{accountNumber}/orders - place orders
    // accounts/{accountNumber}/orders/{orderId} - get specific order info
    // accounts/{accountNumber}/orders/{orderId} - cancel an order
    // accounts/{accountNumber}/orders/{orderId} - replace an order
    // orders - get all order
    // accounts/{accountNumber}/previewOrder

    // accounts/{accountNumber}/transactions
    // accounts/{accountNumber}/transactions/{transactionId}

    // userPreference




    
    

    
    

    
    

//    func fetchAccountData(completion: @escaping (Result<AccountData, ErrorCodes>) -> Void)
//    {
//        guard let url = URL(string: "https://ausgateway.schwab.com/api/is.TradeOrderManagementWeb/v1/TradeOrderManagementWebPort/customer/accounts") else {
//            completion(.failure(.invalidResponse))
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        if let accessToken = self.accessToken
//        {
//            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//        }
//        else
//        {
//            completion(.failure(.notAuthenticated))
//            return
//        }
//        self.performRequest(request, completion: completion)
//    }

//    func fetchPositions(accountId: String, completion: @escaping (Result<[PositionData], ErrorCodes>) -> Void)
//    {
//        guard let url = URL(string: SCHWAB_POSITIONS_URI + accountId ) else {
//            completion(.failure(.invalidResponse))
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        if let accessToken = self.accessToken {
//            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//        }
//        else {
//            completion(.failure(.notAuthenticated))
//            return
//        }
//
//        self.performRequest(request, completion: completion)
//    }
    
    private func performRequest<T: Decodable>(_ request: URLRequest, completion: @escaping (Result<T, ErrorCodes>) -> Void)
    {
        URLSession.shared.dataTask(with: request)
        { data, response, error in

            print( "\n\n RESPONSE:  \(response.debugDescription) \n\n" )

            if let error = error
            {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
            else
            {
                completion(.failure(.invalidResponse))
                return
            }
            
            do
            {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            }
            catch
            {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
}

//private struct OAuthResponse: Decodable
//{
//    let accessToken: String
//    
//    enum CodingKeys: String, CodingKey {
//        case accessToken = "access_token"
//    }
//}
