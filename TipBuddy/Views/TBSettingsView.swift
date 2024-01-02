//
//  TBSettingsView.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 2.01.2024.
//

import SwiftUI

import SwiftUI

struct TBSettingsView: View {
    let viewModel: TBSettingsViewViewModel
    
    init(viewModel: TBSettingsViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.cellViewModels) { viewModel in
            HStack {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.red)
                        .padding(8)
                        .background(Color(viewModel.iconContainerColor))
                        .cornerRadius(6)
                }
                Text(viewModel.title)
                    .padding(.leading, 10)
                
                Spacer()
            }
            .padding(.bottom, 3)
            .onTapGesture {
                viewModel.onTapHandler(viewModel.type)
            }
        }
    }
}

#Preview {
    TBSettingsView(viewModel: .init(cellViewModels: TBSettingsOption.allCases.compactMap({
        return TBSettingsCellViewModel(type: $0) { option in
            
        }
    })))
}
