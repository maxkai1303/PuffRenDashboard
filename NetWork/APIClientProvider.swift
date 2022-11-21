//
//  APIClientProvider.swift
//  PuffRenDashboard
//
//  Created by Max Kai on 2022/11/21.
//

import Foundation

enum APIService {
    case dashboardReport(starDate: Date, endDate: Date)
    
    func encode<T: Codable>(_ data: T) -> Data? {
        do {
            return try JSONEncoder().encode(data)
        } catch {
            print(#function, error) ; return nil
        }
    }
}

extension APIService: TargetType {
    var title: String {
        switch self {
        case .dashboardReport: return "營業紀錄查詢"
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .dashboardReport: return [HTTPHeaderField.contentType.rawValue: HTTPHeaderValue.json.rawValue]
        }
    }
    
    var baseURL: String {
        return "https://puffren.com.tw/"
    }
    
    var body: Data? {
        switch self {
        case .dashboardReport: return nil
        }
    }
    
    var path: String {
        switch self {
        case .dashboardReport(starDate: let starDate, endDate: let endDate):
            return "partner/statusDashboard/report?startDate=\(starDate)&endDate=\(endDate)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .dashboardReport: return .get
        }
    }
    
}
