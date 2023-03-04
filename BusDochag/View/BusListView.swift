//
//  BusListView.swift
//  BusDochag
//
//  Created by 이정훈 on 2023/03/01.
//

import SwiftUI
import Combine

struct BusListView: View {
    @EnvironmentObject var model: Model
    @State var count: Int = 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    //MARK: - 일반버스
    var normalBus: [BusList_Item] {
        model.busList.filter { $0.routetp.rawValue == "일반버스"
        }.sorted(by: {
            $0.arrtime < $1.arrtime
        })
    }
    //MARK: - 직행버스
    var directBus: [BusList_Item] {
        model.busList.filter {
            $0.routetp.rawValue == "직행좌석버스"
        }.sorted(by: {
            $0.arrtime < $1.arrtime
        })
    }
    //MARK: - 광역급행버스
    var expressBus: [BusList_Item] {
        model.busList.filter {
            $0.routetp.rawValue == "광역급행버스"
        }.sorted(by: {
            $0.arrtime < $1.arrtime
        })
    }
    
    //MARK: - body
    var body: some View {
        NavigationView {
            List {
                VStack {
                    BusStopInfoView()
                        .scaledToFill()    //parent view에 대하여 꽉 차게 배치
                        .frame(height: 200)
                        .listRowInsets(EdgeInsets())    //행의 여백 0로 설정
                }
                .listRowSeparator(.hidden)    //행 분리선 삭제
                
                Section("일반버스") {
                    ForEach(normalBus, id: \.self) { bus in
                        ListRowView(bus: bus, arrTime: bus.arrtime)
                    }
                }
                
                Section("직행버스") {
                    ForEach(directBus, id: \.self) { bus in
                        ListRowView(bus: bus, arrTime: bus.arrtime)
                    }
                }
                Section("광역급행버스") {
                    ForEach(expressBus, id: \.self) {bus in
                        ListRowView(bus: bus, arrTime: bus.arrtime)
                    }
                }
            }
            .onReceive(timer) { _ in
                count -= 1
                
                if count == 0 {
                    self.model.fetchBusList()
                    count = 60
                }
            }
            .listStyle(.inset)   //여백 0로 설정
        }
        .navigationTitle("버스 도착 정보")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                RefreshButtonView()
                    .environmentObject(model)
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
