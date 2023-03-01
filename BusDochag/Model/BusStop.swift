//
//  BusStop.swift
//  BusDochag
//
//  Created by 이정훈 on 2023/03/01.
//

import Foundation

// MARK: - BusStop
struct BusStop: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let header: Header
    let body: Body
}

// MARK: - Body
struct Body: Codable {
    let items: Items
    let numOfRows, pageNo, totalCount: Int
}

// MARK: - Items
struct Items: Codable {
    let item: Item
}

// MARK: - Item
struct Item: Codable {
    let gpslati, gpslong: Double
    let nodeid, nodenm: String
    let nodeno: Int
}

// MARK: - Header
struct Header: Codable {
    let resultCode, resultMsg: String
}

