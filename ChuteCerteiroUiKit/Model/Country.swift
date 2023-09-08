//
//  Country.swift
//  ChuteCerteiroUiKit
//
//  Created by Marcos Abreu on 08/09/23.
//

import Foundation

struct Country: Codable {
    let countryID: String
    let countryName: String
    let countryLogo: String
    
    enum CodingKeys: String, CodingKey {
        case countryID = "country_id"
        case countryName = "country_name"
        case countryLogo = "country_logo"
    }
}
