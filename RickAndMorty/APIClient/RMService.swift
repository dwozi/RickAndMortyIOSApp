//
//  RMService.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 7.01.2024.
//

import Foundation


/// Primary API service object to get Rick and Morty data
final class RMService{
    /// Shared Sıngleton Instance
    static let shared = RMService()
    
    /// Privatized Constructor
    private init() {}
    
    /// Send Rick and Morty API call
    /// - Parameters:
    ///   - request: Request Instance
    ///   - completion: Callback with data or error
    public func execute(_ request: RMRequest,completion:@escaping() -> Void){
        
    }
}
