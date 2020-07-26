//
//  ApiManager.swift
//  WeatherApp
//
//  Created by sapere4ude on 2020/07/26.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

enum ApiManagerRequestFunction {
    case get
    case post
    case delete
    case upload
}

enum ApiManagerType{
    case json
    case xml
    case html
}

class ApiManager {
    
    class func query(url: String, function: ApiManagerRequestFunction, header: [String: Any]?, param: [String: Any]?, requestType: ApiManagerType, responseType: ApiManagerType, timeout: UInt, compleHandler: @escaping (Data) -> (), failureHandler: @escaping (Error) -> ()){
        guard let realUrl = URL(string: url) else {
            // todo 에러처리
            return
        }
        var request: URLRequest = URLRequest(url: realUrl)
    }
    
    
    
    
    
    
    
}
