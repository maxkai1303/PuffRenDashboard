//
//  NetWork.swift
//  PuffRenDashboard
//
//  Created by Max Kai on 2022/11/21.
//

import SwiftUI
import Combine

enum HTTPHeaderField: String {
    
    case contentType = "Content-Type"
    
    case auth = "Authorization"
}

enum HTTPHeaderValue: String {
    
    case json = "application/json"
    
    case bearer = ""
}

enum HTTPMethod: String {
    
    case get, post, put, patch = "PATCH"
}


class HTTPClient: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    
    static func request<T: Decodable>(service: TargetType, decodeType: T) -> AnyPublisher<T, Error> {
        let publisher = URLSession.shared.dataTaskPublisher(for: service.makeRequest())
            .receive(on: DispatchQueue.main)
            .tryMap { (data, respones) -> Data in
                guard let httpResponse = respones as? HTTPURLResponse, httpResponse.statusCode >= 200
                else { throw URLError(.badServerResponse) }
                printDetails(target: service, statusCode: httpResponse.statusCode, data: data)
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        return publisher
    }
    
    private static func printDetails(target: TargetType, statusCode: Int, data: Data?) {
        
        guard let data = data else {
            
            print(
            """
            
            ---------- API ----------
            API Name:       \(target.title)
            Request URL:    \(target.baseURL + target.path)
            Headers:        \(String(describing: target.headers))
            Method:         \(target.method)
            Status Code:    \(statusCode)
            Response:       Response data is nil
            ---------- End ----------
            
            """
            )

            return
        }
        print("""
              
              ---------- API ----------
              API Name：     \(target.title)
              Request URL：  \(target.baseURL + target.path)
              Headers：      \(target.headers ?? [:])
              Method：       \(target.method)
              Status Code：  \(statusCode)
              Response：
              \(String(data: data, encoding: .utf8) ?? "Data To String Failure")
              ---------- End ----------
              
              """)
    }
}

