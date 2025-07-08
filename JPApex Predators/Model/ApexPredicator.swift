//
//  ApexPredicator.swift
//  JPApex Predators
//
//  Created by Ankita on 08/07/25.
//


import SwiftUI
import MapKit

struct ApexPredator: Decodable, Identifiable {
    
    let id:Int
    let name:String
    let type:APType
    let latitude:Double
    let longitude:Double
    let movies:[String]
    let movieScenes:[MovieScenes]
    let link:String
    
    var image:String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var locationCoordinate:CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    struct MovieScenes: Decodable, Identifiable{
        let id:Int
        let movie:String
        let sceneDescription:String
    }
    
}


enum APType : String, Decodable,Identifiable,CaseIterable {
    
    var id:APType  {
        self
    }
    
    case land
    case air
    case sea
    case all
    
    var backgroundColor:Color {
        switch self {
        case .land:
            return .brown
        case .air:
            return .teal
        case .sea:
            return .blue
        case .all:
            return .black
        }
    }
    
    var icons:String {
        switch self {
        case .land:
            return "leaf.fill"
        case .air:
            return "wind"
        case .sea:
            return "drop.fill"
        case .all:
            return "square.stack.3d.up.fill"
        }
    }
}

