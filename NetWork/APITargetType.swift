//
//  APITargetType.swift
//  PuffRenDashboard
//
//  Created by Max Kai on 2022/11/21.
//

import Foundation

protocol TargetType {
    
    var title: String { get }
    
    var headers: [String: String]? { get }
    
    var baseURL: String { get }
    
    var body: Data? { get }
    
    var path: String { get }
    
    var method: HTTPMethod { get }
}

extension TargetType {
    
    func makeRequest() -> URLRequest {
        
        var url: URL!
        
        url = URL(string: baseURL + path)
        
        var request = URLRequest(url: url)
        
        request.allHTTPHeaderFields = headers
        
        request.httpMethod = method.rawValue
        
        request.httpBody = body
        
        return request
    }
}
