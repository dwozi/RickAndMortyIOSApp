//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 17.01.2024.
//

import UIKit

/// VC to show details about single episode
final class RMEpisodeDetailViewController: UIViewController {

    private let url : URL?
    
    //MARK: - Init
    
    init(url: URL?){
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Episode"
        view.backgroundColor = .systemGreen

    }
}
