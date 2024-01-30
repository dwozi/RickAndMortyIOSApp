//
//  RMTableLoadingFooterView.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 30.01.2024.
//

import UIKit

final class RMTableLoadingFooterView: UIView {

    private var spinner: UIActivityIndicatorView = {
        let spinner  = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(spinner)
        spinner.startAnimating()
        addConstrints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstrints(){
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 55),
            spinner.heightAnchor.constraint(equalToConstant: 55),

            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            self.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}
