//
//  Constants.swift
//  Places
//
//  Created by Rehan Saleem on 06/10/2021.
//

import Foundation

struct Constants {
    
    static let AppBundleIdentifier = "com.magma.Places"
    
    
    /// Stage Environment
    
    static var BaseUrl = "https://stage.magma.com"
    static var DirectionsUrl = "https://maps.googleapis.com/maps/api"
    
    /// Keys
    struct Key {
        static let GoogleAPI = "AIzaSyDEdbNxBzuj5GtNh073vGdMQOgH3mo3Cc8"
        static let DirectionsAPI = "AIzaSyAiAir1uMz3NwJDd9vjIhqeEuTUgw2S7VM"
    }
}

enum TransportMode: String {
    case Driving = "driving"
    case Walking = "walking"
    case Bicycling = "bicycling"
}
