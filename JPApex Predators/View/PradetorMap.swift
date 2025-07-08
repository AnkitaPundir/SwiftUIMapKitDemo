//
//  PradetorMap.swift
//  JPApex Predators
//
//  Created by Ankita on 08/07/25.
//

import SwiftUI
import MapKit

struct PradetorMap : View {
   
    @State var position:MapCameraPosition
    @State var satelliteView:Bool = false
    
    let predators = Predators()
    
    var body: some View {
        Map(position: $position) {
            ForEach(predators.allApexPredators) { predator in
                Annotation(predator.name,coordinate:predator.locationCoordinate) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height:100)
                        .shadow(color:.white,radius:3)
                        .scaleEffect(x:-1)
                }
            }
        }
        .mapStyle(satelliteView ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing) {
            Button {
                satelliteView.toggle()
            }label: {
                Image(systemName: satelliteView  ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(3)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 7))
                    .shadow(radius:3)
                    .padding()
            }
        }
        .toolbarBackground(.automatic)
    }
    
}


#Preview {
    NavigationStack {
        PradetorMap(position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[2].locationCoordinate, distance: 1000,heading: 250,pitch: 80)))
    }
    .preferredColorScheme(.dark)
}

