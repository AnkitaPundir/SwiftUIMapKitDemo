//
//  File.swift
//  JPApex Predators
//
//  Created by Ankita on 08/07/25.
//
import SwiftUI

struct PredatorListCell: View {
    
    var predator: ApexPredator
   
    var body: some View {
        HStack {
            // Dainasor Image
            Image(predator.image)
                .resizable()
                .scaledToFit()
                .frame(width:100, height:100)
                .shadow(color: .white, radius: 1)
            VStack(alignment:.leading) {
                //Name
                Text(predator.name)
                    .fontWeight(.bold)
                //Type
                Text(predator.type.rawValue)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.horizontal,18)
                    .padding(.vertical,6)
                    .background(predator.type.backgroundColor)
                    .clipShape(.capsule)
            }
        }
    }
    
}

#Preview {
    PredatorListCell(predator:Predators().allApexPredators.first!)
        .preferredColorScheme(.dark)
}
