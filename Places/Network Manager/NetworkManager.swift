//
//  NetworkManager.swift
//  Places
//
//  Created by Rehan Saleem on 06/10/2021.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {
    
    static let sharedInstance = NetworkManager()
    
    func sendGetRequest(url: String, completion: @escaping (AFDataResponse<Any>) -> Void) -> Void {
        AF.request("\(Constants.DirectionsUrl)/" + url, method: .get).responseJSON { response in
            completion(response)
        }
    }
    
    func sendPostRequest(url: String, parameters: Parameters, completion: @escaping (AFDataResponse<String>) -> Void) -> Void {
        AF.request("\(Constants.BaseUrl)/" + url, method: .post, parameters: parameters).responseString { response in
            completion(response)
        }
    }
}
