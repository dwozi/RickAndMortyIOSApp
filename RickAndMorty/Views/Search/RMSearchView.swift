//
//  RMSearchView.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 25.01.2024.
//

import UIKit

final class RMSearchView: UIView {
    
   private let viewModel : RMSearchViewViewModel
    
    //MARK: - Subviews
    
    // SearchInpuViewBar(bar,selection buttons)
    
    // no results view
    
    // results collection view

    //MARK: - Init
     
    init(frame: CGRect,viewModel:RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .red
        translatesAutoresizingMaskIntoConstraints = false
        
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    

}

//MARK: - CollectionView

extension RMSearchView : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
}
