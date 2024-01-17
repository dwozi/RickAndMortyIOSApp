//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 7.01.2024.
//

import Foundation

/// Objects that represents a single API call
final class RMRequest{
    //base url
    //Endpoint
    //path components
    //query parameters
    
    /// API Constants
    private struct Constants{
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    /// Desired endpoint
    private let endpoint : RMEndpoint
    /// Path components for API, if any
    private let pathComponents : [String]
    /// Query arguments for API,if any
   private let queryParamaters : [URLQueryItem]
    
    /// Constructed url for the api request in string format
    private var urlString : String{
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue

        if !pathComponents.isEmpty{
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParamaters.isEmpty{
                string += "?"
            let argumentString = queryParamaters.compactMap({
                guard let value = $0.value else {return nil}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            string += argumentString
        }
        return string
    }
    
    /// Computed % constructed API url
    public var url :URL? {
        return URL(string: urlString)
    }
    /// Desired http Method
    public let httpMethod = "GET"
    //MARK: - Public
    
    /// Construct Request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of paths components
    ///   - queryParamaters: Collection of query parameters
    public init(endpoint: RMEndpoint, pathComponents: [String] = [], queryParamaters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParamaters = queryParamaters
    }
    
    
    /// Attemp to create request
    /// - Parameter url: URL to parse
    convenience init?(url : URL){
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl){
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("/"){
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty{
                let endPointString = components[0] // ENDpoint
                var pathComponents : [String] = []
                if components.count > 1{
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let rmEndpoint = RMEndpoint(rawValue: endPointString) {
                    self.init(endpoint: rmEndpoint,pathComponents: pathComponents)
                    return
                }
            }
        } else if trimmed.contains("?"){
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2{
                let endPointString = components[0]
                let queryItemsString = components[1]
                // value=name&value=name
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else{
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    return URLQueryItem(name: parts[0],
                                        value: parts[1])
                })
                if let rmEndpoint = RMEndpoint(rawValue: endPointString) {
                    self.init(endpoint: rmEndpoint,queryParamaters: queryItems)
                    return
                }
            }
        }
        return nil
    }

}

extension RMRequest {
    static let listCharactersRequest = RMRequest(endpoint: .character)
    
}
