//
//  AppDelegate.swift
//  Places
//
//  Created by Rehan Saleem on 05/10/2021.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /// Initialize Google Map Services
        GMSServices.provideAPIKey(Constants.Key.GoogleAPI)
        
        return true
    }
}

