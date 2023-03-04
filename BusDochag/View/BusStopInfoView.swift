//
//  BusStopInfoView.swift
//  BusDochag
//
//  Created by 이정훈 on 2023/03/04.
//

import SwiftUI

struct BusStopInfoView: View {    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
            Text("동백이마트")
                .font(.title)
        }
    }
}

struct BusStopInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BusStopInfoView()
    }
}
