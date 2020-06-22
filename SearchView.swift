//
//  SearchView.swift
//  SupHealth
//
//  Created by Yahia Berrada on 6/19/20.
//  Copyright © 2020 Supinfo. All rights reserved.
//

import SwiftUI

struct SearchView : View {
    @State private var Countries = [DataModel]()
    @State public var countryName: String
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Country Search")
                
                HStack {
                    TextField("Search...", text: $countryName)
                        .padding(10)
                        .font(Font.system(size: 15, weight: .medium, design: .serif))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                    
                    // if the country name is in Countries
                    if  self.Countries.contains(where: { $0.Country == self.countryName }) {
                        // foreach the country
                        ForEach(0..<self.Countries.count) { item in
                            // if the country is the same that the text value
                            if self.Countries[item].Country == self.countryName {
                                NavigationLink(destination: DetailCountry(country: self.Countries[item])) {
                                    Text("Go")
                                }.buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }.padding(20).navigationBarTitle("Search")
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
                        self.Countries = decodedResponse.Countries
                    }
                    return
                }
            }
            print("\(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
    }
}
