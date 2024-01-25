//
//  RMLocationDetailViewController.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 25.01.2024.
//

import UIKit

final class RMLocationDetailViewController: UIViewController ,RMLocationDetailViewViewModelDelegate,RMLocationDetailViewDelegate{
   
   
    
    
    
    
    private let viewModel: RMLocationDetailViewViewModel
    
    private let detailView = RMLocationDetailView()
   
    
    //MARK: - Init
    
    init(location: RMLocation){
        let url = URL(string: location.url)
        self.viewModel = RMLocationDetailViewViewModel(endpointURL: url)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailView)
        addConstraints()
        detailView.delegate = self
        title = "Location"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        viewModel.delegate = self
        viewModel.fetchLocationData()

    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
       
    }
    
    
    @objc func didTapShare(){
        
    }
    
    //MARK: - View Delegate
    func rmEpisodeDetailView(
        _ detailView: RMLocationDetailView,
        didselect character: RMCharacter
    ){
        let vc = RMCharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - ViewModel Delegate
    func didFetchLocationDetails() {
        detailView.configure(with: viewModel)
    }
}
