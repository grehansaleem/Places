//
//  ServicesManager.swift
//  Places
//
//  Created by Rehan Saleem on 06/10/2021.
//

import Foundation
import Alamofire

extension NetworkManager {
    
    func getDirections(sLatitude:Double, sLongitude: Double, dLatitude:Double, dLongitude: Double, mode:TransportMode, completion: @escaping (AFDataResponse<Any>) -> Void) {
        
        sendGetRequest(
            url:"directions/json?origin=\(sLatitude),\(sLongitude)&destination=\(dLatitude),\(dLongitude)&mode=\(mode.rawValue)&key=\(Constants.Key.DirectionsAPI)",
            completion: completion
        )
    }
}
