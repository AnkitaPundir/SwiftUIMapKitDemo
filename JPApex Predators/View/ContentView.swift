//
//  ContentView.swift
//  JPApex Predators
//
//  Created by Ankita on 08/07/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    let predators = Predators()
    
    @State var searchText:String = ""
    @State var sortByAlphabetical:Bool = false
    @State var currentTypeSelection:APType = .all
    
    var filterDiano:[ApexPredator] {
        predators.filter(by:currentTypeSelection)
        predators.sort(by:sortByAlphabetical)
        return predators.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List(filterDiano) { predator in
                NavigationLink {
                    PredatorDetail(predator:predator, position:.camera(
                        MapCamera(centerCoordinate: predator.locationCoordinate,
                        distance: 30000
                        )))
                } label: {
                    PredatorListCell(predator:predator)
                }
            }
            .navigationTitle("APX Predators")
            .searchable(text:$searchText)
            .autocorrectionDisabled(true)
            .animation(.default,value:searchText)
            .toolbar {
                //Sort by alphabet or movie order (id)
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            sortByAlphabetical.toggle()
                        }
                    }label: {
                        Image(systemName: sortByAlphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: sortByAlphabetical)
                    }
                }
                //Filter by Type
                ToolbarItem(placement: .topBarTrailing) {
                    Menu{
                        Picker("Filter",selection:$currentTypeSelection){
                            ForEach(APType.allCases) { type in
                                Label(type.rawValue,systemImage:type.icons)
                            }
                        }
                    }label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
}

#Preview {
    ContentView()
}

