//
//  RefreshButtonView.swift
//  BusDochag
//
//  Created by 이정훈 on 2023/03/04.
//

import SwiftUI

struct RefreshButtonView: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        Button(action: {
            model.fetchBusList()
        }, label: {
            Image(systemName: "arrow.counterclockwise.circle.fill")
                .foregroundColor(.black)
                .font(.title2)
        })
    }
}

struct RefreshButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RefreshButtonView()
            .environmentObject(Model())
    }
}
