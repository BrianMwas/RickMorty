//
//  RMSettingsView.swift
//  RickMorty
//
//  Created by Brian on 14/04/2023.
//

import SwiftUI

struct RMSettingsView: View {
     let viewModel: RMSettingsViewViewModel
    
    init(viewModel: RMSettingsViewViewModel) {
        self.viewModel = viewModel
    }
    

    var body: some View {
        List(viewModel.cellViewModels) { viewModel in
            HStack {
                if let image = viewModel.iconImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .padding(5)
                        .background(Color(viewModel.iconContainerColor))
                        .cornerRadius(6)
                        
                }
                
                Text(viewModel.title)
                    .padding(.leading, 10)
                Spacer()
            }
            .padding(.vertical, 5)
            .onTapGesture {
                viewModel.onTapHandler(viewModel.type)
            }
        }
    }
}

struct RMSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        RMSettingsView(viewModel: .init(cellViewModels: RMSettingsOption.allCases.compactMap({
            return RMSettingsCellViewModel(type: $0) { option in
                print("We tapped on the preview")
            }
        })))
    }
}
