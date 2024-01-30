//
//  RMSearchResultsView.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 30.01.2024.
//

import UIKit

/// Shows search results UI(collection or tableview as needed)
final class RMSearchResultsView: UIView {
    
    
    private var viewModel : RMSearchResultViewModel?{
        didSet{
            self.proccesViewModel()
        }
    }
    
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        tableView.register(RMLocationTableViewCell.self, forCellReuseIdentifier: RMLocationTableViewCell.identifier)
    
        return tableView
        
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(tableView)
        addConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func proccesViewModel(){
        guard let viewModel = viewModel else {
            return
        }
        switch viewModel {
        case .characters(let viewModels):
            setUpCollectionView()
        case .episodes(let viewModels):
            setUpCollectionView()

        case .locations(let viewModels):
            setUpTableView()
        }
    }
   
    
    private func setUpCollectionView(){
        
    }
    
    private func setUpTableView(){
        tableView.isHidden = false
    }
    private func addConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        ])
        tableView.backgroundColor = .yellow
    }
    

    public func configure(with viewModel: RMSearchResultViewModel){
        self.viewModel = viewModel
    }
}
