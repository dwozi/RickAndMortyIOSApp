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
    ///   - type: the type of object we expect to get back
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        completion:@escaping(Result<T,Error>) -> Void
    
    ){
        
    }
}
