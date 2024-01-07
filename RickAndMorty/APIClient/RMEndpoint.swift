//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 7.01.2024.
//

import Foundation

/// Represent unique API call
@frozen enum RMEndpoint : String {
    /// Endpoint to get character info
    case character
    /// Endpoint to get location info
    case location
    /// Endpoint to get epiode info
    case episode
}
