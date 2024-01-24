//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 17.01.2024.
//

import UIKit

/// VC to show details about single episode
final class RMEpisodeDetailViewController: UIViewController ,RMEpisodeDetailViewViewModelDelegate,RMEpisodeDetailViewDelegate{
    
    

    private let viewModel: RMEpisodeDetailViewViewModel
    
    private let detailView = RMEpisodeDetailView()
   
    
    //MARK: - Init
    
    init(url: URL?){
        self.viewModel = RMEpisodeDetailViewViewModel(endpointURL: url)
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
        title = "Episode"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        viewModel.delegate = self
        viewModel.fetchEpisodeData()

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
        _ detailView: RMEpisodeDetailView,
        didselect character: RMCharacter
    ){
        let vc = RMCharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - ViewModel Delegate
    func didFetchEpisodeDetails() {
        detailView.configure(with: viewModel)
    }
}
