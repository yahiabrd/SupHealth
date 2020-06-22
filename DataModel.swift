//
//  DataModel.swift
//  SupHealth
//
//  Created by Yahia Berrada on 6/19/20.
//  Copyright © 2020 Supinfo. All rights reserved.
//

import Foundation

//struct for the data model of a country
struct DataModel : Codable {
    var Country: String
    var CountryCode: String
    var NewConfirmed: Int
    var TotalConfirmed: Int
    var NewDeaths: Int
    var TotalDeaths: Int
    var NewRecovered: Int
    var TotalRecovered: Int
    
    init(Country: String,
         CountryCode: String,
         NewConfirmed: Int,
         TotalConfirmed: Int,
         NewDeaths: Int,
         TotalDeaths: Int,
         NewRecovered: Int,
         TotalRecovered: Int) {
        
        self.Country = Country
        self.CountryCode = CountryCode
        self.NewConfirmed = NewConfirmed
        self.TotalConfirmed = TotalConfirmed
        self.NewDeaths = NewDeaths
        self.TotalDeaths = TotalDeaths
        self.NewRecovered = NewRecovered
        self.TotalRecovered = TotalRecovered
    }
}
