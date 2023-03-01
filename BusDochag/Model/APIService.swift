//
//  APIService.swift
//  BusDochag
//
//  Created by 이정훈 on 2023/03/01.
//

import Foundation
import Combine

let key = "2iHJaiAhj3is09gMRVLduJ3n3BADIaM4%2FGnabUgm2z7SylYvZn3uRl3aX3dWmB8CLbDQcI5bGM4FKidusGb%2FOg%3D%3D"

struct APIService {
    //버스 정류장 API 호출
    static func fetchBusStop() -> AnyPublisher<BusStop, Error> {
        let tmp: String = "http://apis.data.go.kr/1613000/BusSttnInfoInqireService/getSttnNoList?serviceKey=\(key)&cityCode=31190&nodeNm=동백이마트&nodeNo=29838&numOfRows=10&pageNo=1&_type=json"
        let encodedURL = tmp.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!    //한글 인코딩
        
        return URLSession.shared.dataTaskPublisher(for: URL(string: encodedURL)!)
            .map { $0.data }
            .decode(type: BusStop.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    //버스 정류장 도착 예정 버스 목록 API 호출
    static func fetchBusList(nodeId: String) -> AnyPublisher<BusList, Error> {
        let tmp: String = "http://apis.data.go.kr/1613000/ArvlInfoInqireService/getSttnAcctoArvlPrearngeInfoList?serviceKey=\(key)&cityCode=31190&nodeId=\(nodeId)&numOfRows=10&pageNo=1&_type=json"
        
        let encodedURL = tmp.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return URLSession.shared.dataTaskPublisher(for: URL(string: encodedURL)!)
            .map { $0.data }
            .decode(type: BusList.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    //API 연쇄 호출(버스 정류장 -> 도착 예정 버스 목록 순)
    static func fetchBusListAfterBusStop() -> AnyPublisher<BusList, Error> {
        return fetchBusStop().flatMap{ (busStop: BusStop) in
            fetchBusList(nodeId: busStop.response.body.items.item.nodeid)
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}

