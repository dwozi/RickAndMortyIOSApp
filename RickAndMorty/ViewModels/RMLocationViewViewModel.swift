//
//  RMLocationViewViewModel.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 24.01.2024.
//

import Foundation

final class RMLocationViewViewModel{
    
    private var location: [RMLocation] = []
    
    private var cellViewModels : [String] = []
    
    init(){}
    public func fetchLocation(){
        let request = RMRequest(endpoint: .location)
        RMService.shared.execute(.listLocationsRequest, expecting: String.self) { result in
            switch result {
            case .success(let model):
                break
            case .failure:
                break
            }
        }
    }
    
    private var hasMoreResults : Bool{
        return false
    }
}
