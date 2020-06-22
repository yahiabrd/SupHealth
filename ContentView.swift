//
//  ContentView.swift
//  SupHealth
//
//  Created by Yahia Berrada on 6/16/20.
//  Copyright © 2020 Supinfo. All rights reserved.
//

import SwiftUI

var api  = "https://api.covid19api.com/summary"

struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection){
            GeneralView() //global information
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("General")
                    }
            }
            .tag(0)
            ListView() // informations
                .tabItem {
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("List")
                    }
            }
            .tag(1)
            SearchView(countryName: "") // search
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass.circle.fill")
                        Text("Search")
                    }
            }
            .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView().previewDevice(.init(rawValue: "iPad (7th generation)"))
        }
    }
}
