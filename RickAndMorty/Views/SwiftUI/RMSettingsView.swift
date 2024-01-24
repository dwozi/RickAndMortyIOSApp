//
//  RMSettingsView.swift
//  RickAndMorty
//
//  Created by Hakan Hardal on 23.01.2024.
//

import SwiftUI

struct RMSettingsView: View {
    let viewModel : RMSettingsViewViewModel
    init(viewModel: RMSettingsViewViewModel){
        self.viewModel = viewModel
    }
    
    
    var body: some View {
        List(viewModel.cellViewModels) { viewModel in
            HStack{
                if let image = viewModel.image{
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .padding(8)
                        .background(Color(uiColor: viewModel.iconContainerColor))
                        .clipShape(.rect(cornerRadius: 10))
                }
                Text(viewModel.title)
                    .padding(.leading,10)
                    
                Spacer()
            }
            .padding(.bottom,5)
            .onTapGesture {
                viewModel.onTapHandler(viewModel.type)
            }
            
        }
    }
}

#Preview {
    RMSettingsView(viewModel: .init(cellViewModels: RMSettingsOption.allCases.compactMap({
        return RMSettingsCellViewModel(type: $0){option in
            
        }
    })))
}
