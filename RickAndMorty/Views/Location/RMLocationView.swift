//
//  RMLocationView.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 24.01.2024.
//

import UIKit

final class RMLocationView: UIView {
    private var viewModel : RMLocationViewViewModel?{
        didSet{
            spinner.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            tableView.alpha = 1
            
            
        }
    }
    
    private let tableView : UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.alpha = 0
        tableView.isHidden = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
        return tableView
    }()
    
    private let spinner : UIActivityIndicatorView = {
       let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
        
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(tableView,spinner)
        spinner.startAnimating()
        addConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    public func configure(with viewModel: RMLocationViewViewModel){
        self.viewModel = viewModel
    }
    
}
