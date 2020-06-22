//
//  GeneralView.swift
//  SupHealth
//
//  Created by Yahia Berrada on 6/17/20.
//  Copyright © 2020 Supinfo. All rights reserved.
//

import SwiftUI

//struct for the global informations
struct ResponseGlobal: Codable {
    var Global: GlobalStruct
}

struct GlobalStruct: Codable {
    var NewConfirmed: Int
    var TotalConfirmed: Int
    var NewDeaths: Int
    var TotalDeaths: Int
    var NewRecovered: Int
    var TotalRecovered: Int
}

struct GeneralView: View {
    @State private var Global = [GlobalStruct]()
    
    var body: some View {
        NavigationView {
            List(Global, id: \.NewConfirmed) { item in
                VStack (alignment: .leading) {
                    Text("Confirmed cases")
                    Group {
                        Text("New Confirmed: \(item.NewConfirmed)").font(Font.system(size:20, design: .default).bold()).foregroundColor(Color.red)
                        Text("Total Confirmed: \(item.TotalConfirmed)").font(Font.system(size:20, design: .default).bold())
                    }
                    Spacer()
                    Text("Deaths cases")
                    Group {
                        Text("New Deaths: \(item.NewDeaths)").font(Font.system(size:20, design: .default).bold()).foregroundColor(Color.red)
                        Text("Total Deaths: \(item.TotalDeaths)").font(Font.system(size:20, design: .default).bold())
                    }
                    Spacer()
                    Text("Recovered cases")
                    Group {
                        Text("New Recovered: \(item.NewRecovered)").font(Font.system(size:20, design: .default).bold()).foregroundColor(Color.green)
                        Text("Total Recovered: \(item.TotalRecovered)").font(Font.system(size:20, design: .default).bold())
                    }
                }
            }.navigationBarTitle("Global Information")
        }.navigationViewStyle(StackNavigationViewStyle()) //for ipad
            .onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let url = URL(string: api) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(ResponseGlobal.self, from: data) {
                    DispatchQueue.main.async {
                        self.Global = [decodedResponse.Global]
                    }
                    return
                }
            }
            print("\(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
    }
}
