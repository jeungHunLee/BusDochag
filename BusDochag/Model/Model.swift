//
//  Model.swift
//  BusDochag
//
//  Created by 이정훈 on 2023/03/01.
//

import Foundation
import Combine

class Model: ObservableObject {
    @Published var busList: [BusList_Item] = []
    private var subscribtions = Set<AnyCancellable>()
    
    func fetchBusStop() {
        APIService.fetchBusStop()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("finished")
                }
            } receiveValue: {
                print($0.response.body.items.item.nodeid)
            }
            .store(in: &subscribtions)
    }
    
    func fetchBusList() {
        APIService.fetchBusListAfterBusStop()
            .receive(on: DispatchQueue.main)    //UI 관련 정보 업데이트는 main thread에서 동작
            .sink { compeletion in
                switch compeletion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("finished")
                }
            } receiveValue: {
                self.busList = $0.response.body.items.item
                print(self.busList)
            }
            .store(in: &subscribtions)
    }
}

