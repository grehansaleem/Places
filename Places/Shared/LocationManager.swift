//
//  LocationManager.swift
//  Places
//
//  Created by Rehan Saleem on 06/10/2021.
//

import UIKit
import CoreLocation

protocol LocationManagerDelegate {
    func locationManager(didUpdateLocation location: CLLocation)
}

class LocationManager: NSObject {

    static let sharedInstance = LocationManager()
    
    let locationManager = CLLocationManager()
    
    var delegate: LocationManagerDelegate?
    
    func initLocation() {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        } else {
            showLocationAlert()
        }
    }
}

// MARK: - LocationManager

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        delegate?.locationManager(didUpdateLocation: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func showLocationAlert() {
        let alertController = UIAlertController(
            title: "Location Services Disabled",
            message: "Please enable Location Services in Settings",
            preferredStyle: .alert
        )
        
        let settingsAction = UIAlertAction(
            title: "Settings",
            style: .default
        ) { _ in
            if let URL = URL(string:UIApplication.openSettingsURLString) {
                UIApplication.shared.open(URL, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil
        )
        
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        
        if let topController = UIApplication.topViewController(),
           topController.classForCoder != UIAlertController.classForCoder() {
            topController.present(alertController, animated: true, completion: nil)
        }
    }
}
