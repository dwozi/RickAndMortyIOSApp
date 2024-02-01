//
//  RMSearchResultsView.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 30.01.2024.
//

import UIKit

protocol RMSearchResultsViewDelegate: AnyObject{
    func rmSearchResultsView(_ resultsView: RMSearchResultsView, didTapLocationAt index: Int)
}

/// Shows search results UI(collection or tableview as needed)
final class RMSearchResultsView: UIView {
    
    weak var delegate :  RMSearchResultsViewDelegate?
    
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
    
    
    
    private let collectionView : UICollectionView = {
  
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RMCharacterCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier)
        collectionView.register(RMCharacterEpisodeCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier)
        //Footer for loading 
        collectionView.register(RMFooterLoadingCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()
    
    
    
    /// Tableview ViewModels
    private var locationCellViewModels: [RMLocationTableViewCellViewModel] = []
    /// Collectionview ViewModel
    private var collectionViewCellViewModels : [any Hashable] = []
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(tableView,collectionView)
        addConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func proccesViewModel(){
        guard let viewModel = viewModel else {
            return
        }
        switch viewModel.results {
        case .characters(let viewModels):
            self.collectionViewCellViewModels = viewModels
            setUpCollectionView()
        case .episodes(let viewModels):
            self.collectionViewCellViewModels = viewModels
            setUpCollectionView()

        case .locations(let viewModels):
            setUpTableView(viewModels: viewModels)
        }
    }
   
    
    private func setUpCollectionView(){
        self.tableView.isHidden = true
        self.collectionView.isHidden = false
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        collectionView.reloadData()
        
    }
    
    private func setUpTableView(viewModels: [RMLocationTableViewCellViewModel]){
        tableView.isHidden = false
        tableView.delegate = self
        tableView.dataSource = self
        self.locationCellViewModels = viewModels
        tableView.reloadData()
    }
    private func addConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
            collectionView.topAnchor.constraint(equalTo: topAnchor,constant: 5),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        ])
       
    }
    

    public func configure(with viewModel: RMSearchResultViewModel){
        self.viewModel = viewModel
    }
}
//MARK: - TABLEVIEW

extension RMSearchResultsView : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationCellViewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RMLocationTableViewCell.identifier,
                                                       for: indexPath) as? RMLocationTableViewCell else {
            fatalError("failed to dequeue rmlocationtableviewcell")
        }
        cell.configure(with: locationCellViewModels[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.rmSearchResultsView(self, didTapLocationAt: indexPath.row )
    }
}
//MARK: - COLLECTIONVIEW
extension RMSearchResultsView : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewCellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Character or episode
        let currentViewModel = collectionViewCellViewModels[indexPath.row]
        if let characterVM = currentViewModel as? RMCharacterCollectionViewCellViewModel{
            //character cell
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
                for: indexPath) as? RMCharacterCollectionViewCell else{
                
                fatalError()
            }
            cell.configure(with: characterVM)
            return cell
        }
        
        
        //EPİSODE
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier,
            for: indexPath) as? RMCharacterEpisodeCollectionViewCell else{
            
            fatalError()
        }
        if let episodeVM = currentViewModel as? RMCharacterEpisodeCollectionViewCellViewModel{
            cell.configure(with: episodeVM)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let currentViewModel = collectionViewCellViewModels[indexPath.row]
       
        let bounds = collectionView.bounds
        
        if currentViewModel is RMCharacterCollectionViewCellViewModel{
            //Character size
            let width = (bounds.width-30)/2
            return CGSize(width: width, height: width*1.5)
        }
        
        //Episode size
        let width = bounds.width-20
        return CGSize(width: width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
                let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
                for: indexPath
              )as? RMFooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
        if let viewModel = viewModel, viewModel.shouldShowLoadMoreIndicator{
            footer.startAnimating()
        }
        return footer
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let viewModel = viewModel,viewModel.shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.height,
                      height: 100)
    }
    
    
}
//MARK: -ScrollViewDelegate
extension RMSearchResultsView : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !locationCellViewModels.isEmpty{
            handleLocationPagination(scrollView: scrollView)

        }else{
            //CollectionView
            handleCharacterOrEpisodePagination(scrollView: scrollView)
        }
    }
    
    private func handleCharacterOrEpisodePagination(scrollView: UIScrollView){
    
        guard let viewModel = viewModel,
              !collectionViewCellViewModels.isEmpty,
              viewModel.shouldShowLoadMoreIndicator,
              !viewModel.isLoadingMoreResults else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if  offset >= (totalContentHeight - totalScrollViewFixedHeight - 120){
               
                viewModel.fetchAdditionalResults { [weak self] newResults in
                    //Refresh table
                    self?.tableView.tableFooterView = nil
                    self?.collectionViewCellViewModels = newResults
                    print("should add more results: \(newResults.count)")
                }
            }
            t.invalidate()
        }
    }
    
    
    private func handleLocationPagination(scrollView: UIScrollView){
        guard let viewModel = viewModel,
              !locationCellViewModels.isEmpty,
              viewModel.shouldShowLoadMoreIndicator,
              !viewModel.isLoadingMoreResults else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if  offset >= (totalContentHeight - totalScrollViewFixedHeight - 120){
                DispatchQueue.main.async {
                    self?.showTableLoadingIndicator()
                }
                viewModel.fetchAdditionalLocations { [weak self] newResults in
                    //Refresh table
                    self?.tableView.tableFooterView = nil
                    self?.locationCellViewModels = newResults
                    self?.tableView.reloadData()
                }
            }
            t.invalidate()
        }
    }
    private func showTableLoadingIndicator(){
        let footer = RMTableLoadingFooterView()
        footer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 100)
        tableView.tableFooterView = footer
    }
}
