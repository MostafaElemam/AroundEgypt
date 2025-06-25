//
//  Constants.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 25/06/2025.
//

import Foundation
import Alamofire


struct K {
    //URLS
    static private let baseURL  = "https://aroundegypt.34ml.com"
    static let experiencesURL   = "\(baseURL)/api/v2/experiences"
    static var headers: HTTPHeaders = [
        .accept("application/json"),
        .contentType("application/json")
    ]
        
}
