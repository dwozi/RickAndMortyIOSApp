//
//  RMSearchView.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 25.01.2024.
//

import UIKit

protocol RMSearchViewDelegate: AnyObject{
    func rmSearchView(_ searchView: RMSearchView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption)
}

final class RMSearchView: UIView {
    weak var delegate : RMSearchViewDelegate?
    
   private let viewModel : RMSearchViewViewModel
    
    
    //MARK: - Subviews
    
    // SearchInpuViewBar(bar,selection buttons)
    private let searchInputView = RMSearchInputView()
    
    // no results view
    private let noResultsView = RMNoSearchResultsView()
    
    // results collection view

    //MARK: - Init
     
    init(frame: CGRect,viewModel:RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(noResultsView,searchInputView)
        addConstraints()
        searchInputView.configure(with: RMSearchInputViewViewModel(type: viewModel.config.type))
        searchInputView.delegate = self
        
        viewModel.registerOptionChangeBlock {tuple in

            self.searchInputView.update(option: tuple.0, value: tuple.1)
        }
        
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
           //Search Input View
            searchInputView.topAnchor.constraint(equalTo: topAnchor),
            searchInputView.leftAnchor.constraint(equalTo: leftAnchor),
            searchInputView.rightAnchor.constraint(equalTo: rightAnchor),
            searchInputView.heightAnchor.constraint(equalToConstant: viewModel.config.type == .episode ? 55 : 110),
            
            
            
            //No results
            noResultsView.widthAnchor.constraint(equalToConstant: 150),
            noResultsView.heightAnchor.constraint(equalToConstant: 150),
            noResultsView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noResultsView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
        ])
    }
    
    public func presentKeyboard(){
        searchInputView.presentKeyboard()
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

//MARK: - RMSerachInputViewDelegate
extension RMSearchView : RMSearchInputViewDelegate{
    func rmSearchInputView(_ inputView: RMSearchInputView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
        delegate?.rmSearchView(self, didSelectOption: option)
    }
}
