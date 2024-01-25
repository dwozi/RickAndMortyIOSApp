//
//  RMSearchViewController.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 19.01.2024.
//

import UIKit

//Dynamic search option view
//Render results
//Render no results zero state
//Searcing / API Call

/// Configure Controller to Search
final class RMSearchViewController: UIViewController {
    //Configuration for search session
    struct Config{
        enum `Type`{
            case character // Name | Status | Gender
            case episode// Name
            case location// Name | Type
           
            var title : String{
                switch self{
                case .character:
                    return "Search Characters"
                case .location:
                    return "Search Location"
                case .episode:
                    return "Search Episode"
                    
                }
            }
        }
        let type: `Type`
    }

    private let config: Config
    
    //MARK: - Init
    
    init(config:Config){
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = config.type.title
        view.backgroundColor = .systemBackground
    }
    

    
}
