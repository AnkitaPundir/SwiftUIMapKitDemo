//
//  Predator.swift
//  JPApex Predators
//
//  Created by Ankita on 08/07/25.
//

import Foundation

class Predators {
    
    var apexPredators:[ApexPredator] = []
    var allApexPredators:[ApexPredator] = []
    
    init() {
        decodeApexPredatorsData()
    }
    
    func decodeApexPredatorsData(){
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase //convert the all snake case into camel case...(swifts default)
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            }catch {
                debugPrint("Error while decoding JSON")
            }
        }
    }
    
    func search(for searchText:String) -> [ApexPredator]{
        if searchText.isEmpty {
            return apexPredators
        }else {
            return apexPredators.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func sort(by alphabatical:Bool){
        apexPredators.sort { (pred1, pred2) -> Bool in
            if alphabatical {
                return pred1.name < pred2.name
            }else {
                return pred1.id > pred2.id
            }
        }
    }
    
    func filter(by type:APType){
        if type == .all{
            apexPredators = allApexPredators
        }else{
            apexPredators = allApexPredators.filter { pred in
                pred.type == type
            }
        }
    }
    
}
