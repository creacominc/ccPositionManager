//
//  QuotesResponse.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2025-01-11.
//

import Foundation
import SwiftData

@Model
final class QuotesResponse
{



    private var m_fundamental: Fundamental
    private var m_quote: Quote
    private var m_reference: Reference
    private var m_regular: Regular

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
        }
    }
    /**
 */
}

