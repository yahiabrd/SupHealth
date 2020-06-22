//
//  DetailCountry.swift
//  SupHealth
//
//  Created by Yahia Berrada on 6/18/20.
//  Copyright © 2020 Supinfo. All rights reserved.
//

import SwiftUI

//struct for displaying the details data of a country
struct DetailCountry: View {
    
    var country: DataModel
    
    @State var textToUpdate1 = "Add to favorites"
    @State var textToUpdate2 = "Remove from favorites"
    @State var img1 = "star1"
    @State var img2 = "star2"
    
    var body: some View {
        VStack{
            HStack{
                if favorites.contains(where: { $0.Country == self.country.Country }) { // if the country is not in the favorite
                    Button(action: {
                        //remove the country with the index
                        let index = favorites.firstIndex(where: { $0.Country == self.country.Country })
                        favorites.remove(at: index!)
                        
                        // msg
                        self.textToUpdate1 = "Add to favorites"
                        self.img1 = "star1"
                        self.textToUpdate2 = "Add to favorites"
                        self.img2 = "star1"
                        
                    }) {
                        Image(img2)
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 50.0, height: 50.0)
                        Text(textToUpdate2)
                    }
                    
                }else {
                    Button(action: {
                        //add the object to the array
                        let data = DataModel(Country: self.country.Country,
                                             CountryCode: self.country.CountryCode,
                                             NewConfirmed: self.country.NewConfirmed,
                                             TotalConfirmed: self.country.TotalConfirmed,
                                             NewDeaths: self.country.NewDeaths,
                                             TotalDeaths: self.country.TotalDeaths,
                                             NewRecovered: self.country.NewRecovered,
                                             TotalRecovered: self.country.TotalRecovered)
                        favorites.append(data)
                        
                        //msg
                        self.textToUpdate1 = "Remove from favorites"
                        self.img1 = "star2"
                        self.textToUpdate2 = "Remove from favorites"
                        self.img2 = "star2"
                        
                    }) {
                        Image(img1)
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 50.0, height: 50.0)
                        Text(textToUpdate1)
                    }
                }
            }
            HStack{
                RemoteImage(url: "https://www.countryflags.io/\(country.CountryCode)/flat/64.png")
                Text("\(country.Country)").font(Font.system(size:20, design: .default).bold())
            }
            VStack{
                List{
                    Text("New confirmed: \(country.NewConfirmed)").font(Font.system(size:17, design: .default).bold()).foregroundColor(Color.red)
                    Text("Total confirmed: \(country.TotalConfirmed)")
                    
                    Text("New deaths: \(country.NewDeaths)").font(Font.system(size:17, design: .default).bold()).foregroundColor(Color.red)
                    Text("Total deaths: \(country.TotalDeaths)")
                    
                    Text("New recovered: \(country.NewRecovered)").font(Font.system(size:17, design: .default).bold()).foregroundColor(Color.green)
                    Text("Total recovered: \(country.TotalRecovered)")
                }
            }.padding()
        }
    }
}
