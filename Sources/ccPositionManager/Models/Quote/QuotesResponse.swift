//
//  QuotesResponse.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2025-01-11.
//

import Foundation

@Model
final class QuotesResponse: Codable {


   var response =  {
       "RY": {
         "assetMainType": "EQUITY",
         "assetSubType": "COE",
         "quoteType": "NBBO",
         "realtime": true,
         "ssid": 910435964,
         "symbol": "RY",
         "extended": {
           "askPrice": 0,
           "askSize": 0,
           "bidPrice": 0,
           "bidSize": 0,
           "lastPrice": 125,
           "lastSize": 9,
           "mark": 0,
           "quoteTime": 1736499595000,
           "totalVolume": 0,
           "tradeTime": 1736235303000
         },
         "fundamental": {
           "avg10DaysVolume": 585643,
           "avg1YearVolume": 1057134,
           "declarationDate": "2024-12-03T05:00:00Z",
           "divAmount": 4.11852,
           "divExDate": "2025-01-27T05:00:00Z",
           "divFreq": 4,
           "divPayAmount": 1.02858,
           "divPayDate": "2025-02-24T05:00:00Z",
           "divYield": 3.38499,
           "eps": 8.07986,
           "fundLeverageFactor": 0,
           "lastEarningsDate": "2024-12-04T05:00:00Z",
           "nextDivExDate": "2025-04-28T04:00:00Z",
           "nextDivPayDate": "2025-05-27T04:00:00Z",
           "peRatio": 15.05843
         },
         "quote": {
           "52WeekHigh": 128.05,
           "52WeekLow": 93.97,
           "askMICId": "ARCX",
           "askPrice": 127,
           "askSize": 1,
           "askTime": 1736557200182,
           "bidMICId": "ARCX",
           "bidPrice": 82.27,
           "bidSize": 1,
           "bidTime": 1736546065711,
           "closePrice": 121.67,
           "highPrice": 121.04,
           "lastMICId": "XNYS",
           "lastPrice": 118.09,
           "lastSize": 1,
           "lowPrice": 118.04,
           "mark": 118.42,
           "markChange": -3.25,
           "markPercentChange": -2.67115969,
           "netChange": -3.58,
           "netPercentChange": -2.94238514,
           "openPrice": 121,
           "postMarketChange": -0.33,
           "postMarketPercentChange": -0.27866914,
           "quoteTime": 1736557200182,
           "securityStatus": "Normal",
           "totalVolume": 731188,
           "tradeTime": 1736553588366
         },
         "reference": {
           "cusip": "780087102",
           "description": "Royal Bank of Canada",
           "exchange": "N",
           "exchangeName": "NYSE",
           "isHardToBorrow": true,
           "isShortable": true,
           "htbRate": 0
         },
         "regular": {
           "regularMarketLastPrice": 118.42,
           "regularMarketLastSize": 45019,
           "regularMarketNetChange": -3.25,
           "regularMarketPercentChange": -2.67115969,
           "regularMarketTradeTime": 1736553600002
         }
       }
     }
    /**
 */
}
