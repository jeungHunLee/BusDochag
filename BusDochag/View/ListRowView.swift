//
//  ListRowView.swift
//  BusDochag
//
//  Created by 이정훈 on 2023/03/04.
//

import SwiftUI

struct ListRowView: View {
    var bus: BusList_Item
    @State var arrTime: Int = 0
    //Timer Publisher as a Combine
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            //MARK: - 버스 번호
            Text("\(bus.routeno.getAssociatedValue())번")
                .font(.title3)
            
            Spacer()
            
            //MARK: - arrival time
            if arrTime < 60 {
                Text("잠시 후 도착")
            } else {
                Text("\(arrTime / 60)분 \(arrTime % 60)초")
            }
            
            //MARK: - 남은 정류장 수
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .frame(width: 57, height: 20)
                    .foregroundColor(.white)
                    .overlay{
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(.gray, lineWidth: 1)
                    }
                Text("\(bus.arrprevstationcnt)번째 전")
                    .foregroundColor(.gray)
                    .font(.caption2)
            }
        }
        .onReceive(timer) { _ in
            arrTime -= 1    //onReceive로 전달된 Publisher가 data를 방출할때 수행할 작업
        }
        .padding()
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(bus: BusList_Item(arrprevstationcnt: 15, arrtime: 300, nodeid: Nodeid.ggb228000158, nodenm: Nodenm.동백이마트, routeid: "DJB30300002", routeno: Routeno.integer(5), routetp: Routetp.일반버스, vehicletp: Vehicletp.일반차량))
    }
}
