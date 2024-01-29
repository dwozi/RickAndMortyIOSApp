//
//  RMSearchResultViewModel.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 30.01.2024.
//

import Foundation

enum RMSearchResultViewModel{
    case characters([RMCharacterCollectionViewCellViewModel])
    case episodes([RMCharacterEpisodeCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
}
