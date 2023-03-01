//
//  BusListView.swift
//  BusDochag
//
//  Created by 이정훈 on 2023/03/01.
//

import SwiftUI

struct BusListView: View {
    @EnvironmentObject var model: Model
    var body: some View {
        List {
            ForEach(model.busList, id: \.self) { bus in
                VStack {
                    Text("bus.routeno.string")
                    Text("\(bus.arrtime)")
                }
            }
        }
    }
}

struct BusListView_Previews: PreviewProvider {
    static var previews: some View {
        BusListView()
            .environmentObject(Model())
    }
}
