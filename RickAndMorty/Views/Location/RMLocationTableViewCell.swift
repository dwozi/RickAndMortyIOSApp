//
//  RMLocationTableViewCell.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 24.01.2024.
//

import UIKit

class RMLocationTableViewCell: UITableViewCell {

    static let identifier = "RMLocationTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor  = .secondarySystemBackground
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: RMLocationTableViewCellViewModel){
        
    }
}
