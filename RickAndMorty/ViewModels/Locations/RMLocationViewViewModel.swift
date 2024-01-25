//
//  RMLocationViewViewModel.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 24.01.2024.
//

import Foundation

protocol RMLocationViewViewModelDelegate : AnyObject{
    func didFetchInitialLocations()
}

final class RMLocationViewViewModel{
    weak var delegate : RMLocationViewViewModelDelegate?
    private var locations: [RMLocation] = []{
        didSet{
            for location in locations{
                let cellViewModel = RMLocationTableViewCellViewModel(location: location)
                if !cellViewModels.contains(cellViewModel){
                    cellViewModels.append(cellViewModel)
                }
            }
        }
    }
    
    private var apiInfo : RMGetAllLocationsResponse.Info?
    
   public private(set) var cellViewModels : [RMLocationTableViewCellViewModel] = []
    
    init(){}
    
    public func location(at index:Int) -> RMLocation?{
        guard index < locations.count, index >= 0 else {
            return nil
        }
        return self.locations[index]
    }
    
    
    public func fetchLocation(){
        let request = RMRequest(endpoint: .location)
        
        RMService.shared.execute(
            .listLocationsRequest,
            expecting: RMGetAllLocationsResponse.self
        
        ) { [weak self] result in
        
            switch result {
            case .success(let model):
                self?.apiInfo = model.info
                self?.locations = model.results
                DispatchQueue.main.async {
                    self?.delegate?.didFetchInitialLocations()
                }
            case .failure:
                break
            }
        }
    }
    
   
    private var hasMoreResults : Bool{
        return false
    }
}
