//
//  BusListView.swift
//  BusDochag
//
//  Created by 이정훈 on 2023/03/01.
//

import SwiftUI

struct BusListView: View {
    @EnvironmentObject var model: Model
    var normalBus: [BusList_Item] {
        model.busList.filter { $0.routetp.rawValue == "일반버스"
        }
    }
    var directBus: [BusList_Item] {
        model.busList.filter {
            $0.routetp.rawValue == "직행좌석버스"
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .frame(height: 100)
                    Text("동백이마트")
                        .font(.title)
                }
                Section("일반버스") {
                    ForEach(normalBus, id: \.self) { bus in
                        
                        VStack {
                            Text(bus.routeno.getAssociatedValue())
                            Text("\(bus.arrtime)초")
                        }
                    }
                }
                
                Section("직행버스") {
                    ForEach(directBus, id: \.self) { bus in
                        
                        VStack {
                            Text(bus.routeno.getAssociatedValue())
                            Text("\(bus.arrtime)초")
                        }
                    }
                }
            }
            .listStyle(.inset)   //여백 0로 설정
        }
        //.toolbar
    }
}

struct BusListView_Previews: PreviewProvider {
    static var previews: some View {
        BusListView()
            .environmentObject(Model())
    }
}
