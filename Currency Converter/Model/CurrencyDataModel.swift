//
//  CurrencyDataModel.swift
//  Currency Converter
//
//  Created by Adwait Barkale on 08/09/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import Foundation

struct CurrencyDataModel: Codable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: [String: Double]
}
