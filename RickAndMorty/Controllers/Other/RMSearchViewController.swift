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
    private let viewModel : RMSearchViewViewModel
    private let searchView : RMSearchView
    
    //MARK: - Init
    
    init(config:Config){
        let viewModel = RMSearchViewViewModel(config: config)
        self.viewModel = viewModel
        self.searchView = RMSearchView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.config.type.title
        view.backgroundColor = .systemBackground
        view.addSubview(searchView)
        addConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapExecuteSearch))
    }
    
    @objc func didTapExecuteSearch(){
//        viewModel.executeSearch()
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    

    
}
