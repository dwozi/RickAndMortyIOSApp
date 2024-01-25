//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 7.01.2024.
//

import UIKit

/// Controller to show and search for Location
final class RMLocationViewController: UIViewController ,RMLocationViewViewModelDelegate,RMLocationViewDelegate{
    
    private let primaryView = RMLocationView()
    private let viewModel = RMLocationViewViewModel()
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        primaryView.delegate = self
        
        view.addSubview(primaryView)
        view.backgroundColor = .systemBackground
        title = "Location"
        addSearchButton()
        addConstraints()
        viewModel.delegate = self
        viewModel.fetchLocation()
    }
    
    
    private func addSearchButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    @objc func didTapSearch(){
        
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    //MARK: - LocationViewDelegate
    
    func rmLocationView(_ locationView: RMLocationView, didselect location: RMLocation) {
        let vc = RMLocationDetailViewController(location: location)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    

 
    //MARK: - LocationViewModel Delegate
    
    func didFetchInitialLocations(){
        primaryView.configure(with: viewModel)
    }
    

}
