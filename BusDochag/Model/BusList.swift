//
//  BusList.swift
//  BusDochag
//
//  Created by 이정훈 on 2023/03/01.
//

import Foundation

// MARK: - BusList
struct BusList: Codable {
    let response: BusList_Response
}

// MARK: - Response
struct BusList_Response: Codable {
    let header: BusList_Header
    let body: BusList_Body
}

// MARK: - Body
struct BusList_Body: Codable {
    let items: BusList_Items
    let numOfRows, pageNo, totalCount: Int
}

// MARK: - Items
struct BusList_Items: Codable {
    let item: [BusList_Item]
}

// MARK: - Item
struct BusList_Item: Hashable, Codable {
    let arrprevstationcnt, arrtime: Int
    let nodeid: Nodeid
    let nodenm: Nodenm
    let routeid: String
    let routeno: Routeno
    let routetp: Routetp
    let vehicletp: Vehicletp
}

enum Nodeid: String, Codable {
    case ggb228000158 = "GGB228000158"
}

enum Nodenm: String, Codable {
    case 동백이마트 = "동백이마트"
}

enum Routeno: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Routeno.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Routeno"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
    
    func getAssociatedValue() -> String {
        switch self {
        case .integer(let x):
            return String(x)
        case .string(let x):
            return x
        }
    }
}

enum Routetp: String, Codable {
    case 일반버스 = "일반버스"
    case 직행좌석버스 = "직행좌석버스"
    case 광역급행버스 = "광역급행버스"
}

enum Vehicletp: String, Codable {
    case 일반차량 = "일반차량"
}

// MARK: - Header
struct BusList_Header: Codable {
    let resultCode, resultMsg: String
}

// MARK: - BusList_Item extension
extension BusList_Item {    //List View에 사용하기 위해 배열(model)의 각 요소는 Hashable 프로토콜을 준수해야 함
    static func == (lhs: BusList_Item, rhs: BusList_Item) -> Bool {    //Hashable 프로토콜은 Equatable 프로토콜을 준수해야함
        lhs.routeid == rhs.routeid && lhs.arrtime == rhs.arrtime
    }
    
    func hash(into hasher: inout Hasher) {    //Hashable 프로토콜을 준수하기 위한 hash 함수
        hasher.combine(self.routeid)    //hasher에게 hash해 사용할 식별 가능한 값 전달하여 hashvalue 생성
        hasher.combine(self.arrtime)
    }
}
