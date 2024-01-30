//
//  RMLocationView.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 24.01.2024.
//

import UIKit

protocol RMLocationViewDelegate: AnyObject{
    func rmLocationView(_ locationView: RMLocationView,
                        didselect location: RMLocation)
}

final class RMLocationView: UIView {
    
    public weak var delegate : RMLocationViewDelegate?
    
    private var viewModel : RMLocationViewViewModel?{
        didSet{
            spinner.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            RMLocationView.animate(withDuration: 0.5) {
                self.tableView.alpha = 1
            }
            viewModel?.registerDidFinishPaginationBlock { [weak self] in
                DispatchQueue.main.async {
                    self?.tableView.tableFooterView = nil
                    
                    self?.tableView.reloadData()
                }
            }
            
        }
    }
    
    
    
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.alpha = 0
        tableView.isHidden = true
        tableView.register(RMLocationTableViewCell.self, forCellReuseIdentifier: RMLocationTableViewCell.identifier)
    
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
        configureTable()
        
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureTable(){
        tableView.delegate = self
        tableView.dataSource = self
        
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
extension RMLocationView : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let locationModel = viewModel?.location(at: indexPath.row) else {
           return
        }
        delegate?.rmLocationView(self, didselect: locationModel)

    }
}
extension RMLocationView : UITableViewDataSource{
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModels = viewModel?.cellViewModels else {
            fatalError()
        }
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RMLocationTableViewCell.identifier,
            for: indexPath
        ) as? RMLocationTableViewCell else {
            fatalError()
        }
        //var content = cell.defaultContentConfiguration()
      
        let cellViewModel = cellViewModels[indexPath.row]
        cell.configure(with: cellViewModel)
        
        
        
        
        
        //cell.contentConfiguration = content
        return cell
    }
    
    
}

extension RMLocationView : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //
        guard let viewModel = viewModel,
            !viewModel.cellViewModels.isEmpty,
              viewModel.shouldShowLoadMoreIndicator,
              !viewModel.isLoadingMoreLocations else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if  offset >= (totalContentHeight - totalScrollViewFixedHeight - 120){
                DispatchQueue.main.async {
                    self?.showLoadingIndicator()
                }
                viewModel.fetchAdditionalLocations()
                
            }
            t.invalidate()
        }
    }
    
    private func showLoadingIndicator(){
        let footer = RMTableLoadingFooterView()
        footer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 100)
        tableView.tableFooterView = footer
    }
}
