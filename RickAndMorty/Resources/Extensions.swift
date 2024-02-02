//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 9.01.2024.
//

import UIKit
extension UIView {
    func addSubviews(_ views : UIView...){
        views.forEach({
            addSubview($0)
        })
    }
}

extension UIDevice{
    static let isIphone = UIDevice.current.userInterfaceIdiom == .phone
    
}
