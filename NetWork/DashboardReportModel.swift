//
//  DashboardReportModel.swift
//  PuffRenDashboard
//
//  Created by Max Kai on 2022/11/21.
//

import Foundation

// MARK: - DashboardReportElement
struct DashboardReportElement: Codable {
    let recordID: Int
    let reportDate, partnerID, fullname: String
    let expectedOpenTime: JSONNull?
    let openLocation, openTime, closeTime: String?
    let openStatus: Int
    let reportStatus: Int?
    let sales: Int
    let reportTime: String?

    enum CodingKeys: String, CodingKey {
        case recordID = "recordId"
        case reportDate = "report_date"
        case partnerID = "partner_id"
        case fullname
        case expectedOpenTime = "expected_open_time"
        case openLocation = "open_location"
        case openTime = "open_time"
        case closeTime = "close_time"
        case openStatus = "open_status"
        case reportStatus = "report_status"
        case sales
        case reportTime = "report_time"
    }
}

typealias DashboardReport = [DashboardReportElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    func hash(into hasher: inout Hasher) {
        return hasher.combine(0)
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
