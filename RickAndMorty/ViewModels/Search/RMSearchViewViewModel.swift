//
//  RMSearchViewViewModel.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 25.01.2024.
//

import Foundation

//Responsibilities
// - show search results
// - show no results view
// - kick off API requests

final class RMSearchViewViewModel{
    let config : RMSearchViewController.Config
    
    private var optionMap: [RMSearchInputViewViewModel.DynamicOption: String] = [:]
    private var searchText = ""
    private var optionMapUpdateBlock: (((RMSearchInputViewViewModel.DynamicOption,String)) -> Void)?
    
    private var searchResultHandler : ((RMSearchResultViewModel) -> Void)?
    
    
   
    //MARK: -Init
   
    init(config: RMSearchViewController.Config){
        self.config = config
    }
    
    
    
    //MARK: - Public
    
    public func registerSearchResultHandler(_ block: @escaping (RMSearchResultViewModel) -> Void ){
        self.searchResultHandler = block
    }
    
    public func executeSearch(){

        //Build arguments
        var queryParams : [URLQueryItem] = [
            URLQueryItem(name: "name", value: searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))//SONRADAN EKLENDİ .ADDINGPERCENTENCODING
        ]

        //Add Options
        queryParams.append(contentsOf:  optionMap.enumerated().compactMap({ _, element in
            let key: RMSearchInputViewViewModel.DynamicOption = element.key
            let value: String = element.value
            return URLQueryItem(name: key.queryArgument, value: value)
        }))
        
//       send API call, Create Request
        let request = RMRequest(
            endpoint: config.type.endpoint,
            queryParamaters: queryParams
        )
        switch config.type.endpoint{
        case . character:
            makeSearchAPICall(RMGetAllCharacterResponse.self, request: request)
        case .episode:
            makeSearchAPICall(RMGetAllEpisodesResponse.self, request: request)
        case .location:
            makeSearchAPICall(RMGetAllLocationsResponse.self, request: request)
        }
        

//        switch config.type.endpoint{
//        case .character: 
//            RMService.shared.execute(request, expecting: RMGetAllCharacterResponse.self) { result in
//                //       notify view of results, no result or error
//
//                switch result {
//                case .success(let model):
//                    //Episodes , Characters: CollectionView,Location: TableView
//                    print(String(describing: model.results.count))
//                case .failure(let failure):
//                    break
//                }
//            }
//        case .episode: 
//            RMService.shared.execute(request, expecting: RMGetAllEpisodesResponse.self) { result in
//                //       notify view of results, no result or error
//
//                switch result {
//                case .success(let model):
//                    //Episodes , Characters: CollectionView,Location: TableView
//                    print(String(describing: model.results.count))
//                case .failure(let failure):
//                    break
//                }
//            }
//        case .location:
//            
//        }
    }
    
    private func makeSearchAPICall<T: Codable>(_ type: T.Type,request: RMRequest){
        RMService.shared.execute(request, expecting: type) { [weak self] result in
            //       notify view of results, no result or error

            switch result {
            case .success(let model):
                //Episodes , Characters: CollectionView,Location: TableView
                self?.proccesSearchResults(model: model)
                
            case .failure(let failure):
                break
            }
        }
    }
    private func proccesSearchResults(model: Codable){
        var resultsVM: RMSearchResultViewModel?
        if let characterResults = model as? RMGetAllCharacterResponse {
            
            resultsVM = .characters(characterResults.results.compactMap({
                return RMCharacterCollectionViewCellViewModel(
                    characterName: $0.name,
                    characterStatus: $0.status,
                    characterImageUrl: URL(string: $0.image)
                )
            }))
        }
        else if let episodesResults = model as? RMGetAllEpisodesResponse {
            resultsVM = .episodes(episodesResults.results.compactMap({
                return RMCharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: $0.url))
            }))
        }
        else if let locationsResults = model as? RMGetAllLocationsResponse {
            resultsVM = .locations(locationsResults.results.compactMap({
                return RMLocationTableViewCellViewModel(location: $0)
            }))
        }
        
        if let results = resultsVM{
            self.searchResultHandler?(results)

        }else{
            //Fallback
        }
    }
    public func set(query text: String){
        self.searchText = text
    }
    
    public func set(value: String, for option: RMSearchInputViewViewModel.DynamicOption){
        optionMap[option] = value
        let tuple  = (option,value)
        optionMapUpdateBlock?(tuple)
    }
    
    public func registerOptionChangeBlock(_ block: @escaping((RMSearchInputViewViewModel.DynamicOption,String)) -> Void){
        self.optionMapUpdateBlock = block
    }
    
}
