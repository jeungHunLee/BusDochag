//
//  ContentView.swift
//  BusDochag
//
//  Created by 이정훈 on 2023/03/01.
//

import SwiftUI

struct ContentView: View {
    @State private var showNext: Bool = false
    @StateObject var model: Model = Model()
    
    var body: some View {
        NavigationView {
            VStack {
                Button("버스 도착 정보 확인") {
                    showNext.toggle()
                    self.model.fetchBusList()
                }
            }
            .background(
                NavigationLink("", destination: BusListView().environmentObject(model), isActive: $showNext)
                    /*.onDisappear{
                        self.model.busList = []
                    }*/
            )
            //.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
