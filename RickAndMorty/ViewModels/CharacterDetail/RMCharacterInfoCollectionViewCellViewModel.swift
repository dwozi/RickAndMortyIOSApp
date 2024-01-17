//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 15.01.2024.
//

import Foundation
import UIKit

final class RMCharacterInfoCollectionViewCellViewModel{
    private let type : `Type`
    private let value: String
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        return formatter
    }()
    
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        return formatter
    }()
   
    
    public var title : String{
        type.displayTitle
        
    }
    public var displayValue : String{
        if value.isEmpty{return "None"}

        
        if let date = Self.dateFormatter.date(from: value),
           type == .created{
            return Self.shortDateFormatter.string(from: date)
        }
        return value
    }

    public var iconImage : UIImage? {
        
        return type.iconImage
    }
    
    public var tintColor : UIColor{
        return type.tintColor
    }
    
    
    enum `Type` : String{
        case status
        case gender
        case type
        case species
        case origin
        case created
        case location
        case episodeCount
        
        var tintColor: UIColor{
            switch self{
            case .status:
                return .systemBlue
            case .gender:
                return .systemRed
            case .type:
                return .systemPurple
            case .species:
                return .systemGreen
            case .origin:
                return .systemOrange
            case .created:
                return .systemPink
            case .location:
                return .systemYellow
            case .episodeCount:
                return .systemMint
            }
        }
        
        
        var iconImage: UIImage? {
            switch self{
            case .status:
                return UIImage(systemName: "bell")
            case .gender:
                return UIImage(systemName: "bell")
            case .type:
                return UIImage(systemName: "bell")
            case .species:
                return UIImage(systemName: "bell")
            case .origin:
                return UIImage(systemName: "bell")
            case .created:
                return UIImage(systemName: "bell")
            case .location:
                return UIImage(systemName: "bell")
            case .episodeCount:
                return UIImage(systemName: "bell")
            }
        }
        
        var displayTitle: String{
            
            switch self{
            case .status,
                    .gender,
                    .type,
                    .species,
                    .origin,
                    .created,
                    .location:
                return rawValue.uppercased()
            case .episodeCount:
                return "EPISODE COUNT"
            }
        }
    }
    
//        .init(value: character.status.text, title: "Status"),
//        .init(value: character.gender.rawValue, title: "Gender"),
//        .init(value: character.type, title: "Type"),
//        .init(value: character.species, title: "Species"),
//        .init(value: character.origin.name, title: "Origin"),
//        .init(value: character.location.name, title: "Location"),
//        .init(value: character.created, title: "Created"),
//        .init(value: "\(character.episode.count)", title: "Total Episodes"),
    
    
    init(type: `Type`, value: String) {
        self.value = value
        self.type = type
    }
}
