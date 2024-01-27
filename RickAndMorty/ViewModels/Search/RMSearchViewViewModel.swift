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
    
   
    
   
    //MARK: -Init
   
    init(config: RMSearchViewController.Config){
        self.config = config
    }
    
    
    //MARK: - Public
    public func executeSearch(){
//          Create Request based on filters
//        send API call
//        notify view of results, no result or error
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
