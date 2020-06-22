//
//  ListView.swift
//  SupHealth
//
//  Created by Yahia Berrada on 6/17/20.
//  Copyright © 2020 Supinfo. All rights reserved.
//

import SwiftUI

//response countries
struct ResponseCountries: Codable {
    var Countries: [DataModel]
}

//favorites array
var favorites: Array<DataModel> = Array()

struct ListView: View {
    @State private var Countries = [DataModel]()
    @State private var showFavorites = false

    var body: some View {
        NavigationView {
            if self.showFavorites == true { // if click on the favorite toggle
                if(favorites.count == 0) { // if there isn't favorites
                    Text("No added favorites")
                        .navigationBarTitle("Informations")
                        .navigationBarItems(trailing:
                            Toggle("Show Favorites Only", isOn: $showFavorites)
                    )
                }else {
                    List(favorites, id: \.Country) { item in //list of favorites
                        NavigationLink(destination: DetailCountry(country: item)) {
                            HStack {
                                RemoteImage(url: "https://www.countryflags.io/\(item.CountryCode)/flat/64.png")
                                Text(item.Country)
                                    .font(.headline)
                            }
                        }
                    }.navigationBarTitle("Informations")
                        .navigationBarItems(trailing:
                            Toggle("Show Favorites Only", isOn: $showFavorites)
                    )
                }
            }else { // if favorites not clicked => display all countries
                List(Countries, id: \.Country) { item in
                    NavigationLink(destination: DetailCountry(country: item)) {
                        HStack {
                            RemoteImage(url: "https://www.countryflags.io/\(item.CountryCode)/flat/64.png")
                            Text(item.Country)
                                .font(.headline)
                        }
                    }
                }.navigationBarTitle("Informations")
                    .navigationBarItems(trailing:
                        Toggle("Show Favorites Only", isOn: $showFavorites)
                )
            }
        }.navigationViewStyle(StackNavigationViewStyle())
            .onAppear(perform: loadData)
    }
    
    //api service
    func loadData() {
        guard let url = URL(string: api) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(ResponseCountries.self, from: data) {
                    DispatchQueue.main.async {
                        self.Countries = decodedResponse.Countries //recup les donnees
                    }
                    return
                }
            }
            print("\(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
    }
}

