//
//  Default500ApiClient.swift
//  500pxDemo
//
//  Created by Dan on 2017-05-16.
//  Copyright © 2017 Dan. All rights reserved.
//

import Foundation
import Alamofire

// Communication

struct FiveHundredPxAPI {
    
    enum Router: URLRequestConvertible {
        
        static let baseURL = "https://api.500px.com/v1"
        static let consumerKey = "NovFfX5bqw61jVlGUkjvYGi5yl6nKPD8G96y7uog"
        
        case Photos(PhotosFeature, Int)
        case PhotoDetails(Int, ImageSize)
        
        func asURLRequest() throws -> URLRequest {
            let path: String
            let parameters: [String: Any]
            switch self {
            case .Photos(let feature, let page):
                path = "/photos"
                parameters = ["consumer_key": Router.consumerKey, "page": "\(page)", "feature": "\(feature.rawValue)", "rpp": "50"]
                break
            case .PhotoDetails(let photoId, let photoSize):
                path = "/photos/\(photoId)"
                parameters = ["consumer_key": Router.consumerKey, "image_size": "\(photoSize.rawValue)"]
                break
            }
            
            let destinationURL = URL(string: Router.baseURL)
            let destinationURLRequest = URLRequest(url: destinationURL!.appendingPathComponent(path))
            let encoding = URLEncoding.default
            
            return try encoding.encode(destinationURLRequest, with: parameters)
        }
    }
    

}


// Models

