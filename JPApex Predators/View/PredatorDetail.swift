//
//  PredatorDetail.swift
//  JPApex Predators
//
//  Created by Ankita on 08/07/25.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    
    let predator:ApexPredator
    
    @State var position:MapCameraPosition
    
    @Namespace var animation
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ZStack(alignment:.bottomTrailing) {
                    
                    //backgroud Image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(stops:[Gradient.Stop(color: .clear, location: 0.85), Gradient.Stop(color: .black, location: 1)], startPoint: .top, endPoint: .bottom)
                        }
                    
                    //Diano Image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5, height: geo.size.height/3.7)
                        .scaleEffect(x:-1)
                        .shadow(color: .black, radius:7)
                        .offset(y:20)
                }
                
                VStack(alignment:.leading) {
                    //Diano Name
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    //Current Location map
                    NavigationLink {
                        PradetorMap(position:.camera(MapCamera(
                            centerCoordinate: Predators().apexPredators[2].locationCoordinate,
                            distance: 1000,
                            heading: 250,
                            pitch: 80)))
                        .navigationTransition(.zoom(sourceID: 1
                                                    , in:animation))
                    }label: {
                        Map(position:$position) {
                            Annotation(predator.name,coordinate: predator.locationCoordinate) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                                    .foregroundColor(.red)
                            }
                            .annotationTitles(.hidden)
                        }
                        .frame(height: 120)
                        .clipShape(.rect(cornerRadius: 15))
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing,5)
                            
                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .padding([.leading,.bottom],5)
                                .padding(.trailing,10)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 12))
                        }
                    }
                    .matchedTransitionSource(id: 1, in: animation)
                    
                    //Appears in
                    Text("Appears in:")
                        .font(.title3)
                    ForEach(predator.movies, id:\.self) { movie in
                        Text(" • " + movie)
                            .font(.subheadline)
                    }
                    
                    //Movie Momments
                    Text("Moments in Movie:")
                        .font(.title)
                        .padding(.top,20)
                    
                    ForEach(predator.movieScenes) { scene in
                        Text(scene.sceneDescription)
                            .font(.subheadline)
                            .padding(.bottom,15)
                    }
                    
                    //Link to web Page
                    Text("Read more:")
                        .font(.title3)
                        .padding(.top,20)
                    
                    if let url  = URL(string: predator.link) {
                        Link(predator.link,destination:url)
                            .font(.caption)
                            .foregroundStyle(.blue)
                    }
                    
                }
                .padding()
                .frame(width: geo.size.width,alignment:.leading)
                
            }
        }
        .ignoresSafeArea()
        .toolbarBackground(.automatic)
        
    }
}

#Preview {
    
    let predator = Predators().apexPredators[2]
    NavigationStack {
        PredatorDetail(predator: predator,
                       position:.camera(
                        MapCamera(centerCoordinate: predator.locationCoordinate,
                                  distance: 30000
                                 )))
        .preferredColorScheme(.dark)
    }
    
}
