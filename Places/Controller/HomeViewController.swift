//
//  HomeViewController.swift
//  Places
//
//  Created by Rehan Saleem on 05/10/2021.
//

import UIKit
import GoogleMaps

class HomeViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var mapView   : GMSMapView!
    
    @IBOutlet weak var txtSearch  : UITextField!
    @IBOutlet weak var imgPlace   : UIImageView!
    @IBOutlet weak var lblName    : UILabel!
    @IBOutlet weak var lblTime    : UILabel!
    
    @IBOutlet weak var viewDetailShown   : NSLayoutConstraint!
    @IBOutlet weak var viewDetailHidden  : NSLayoutConstraint!
    
    // MARK: - Variables
    
    var slocation   = CLLocation()
    
    var polypoints : String?
    var polyline   : GMSPolyline?
    
    var sPlace     : Place?
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mapView.delegate = self
        
        LocationManager.sharedInstance.initLocation()
        LocationManager.sharedInstance.delegate = self
    }
    
    func showDetailView(_ toShow: Bool) {
        DispatchQueue.main.async {
            if toShow {
                self.viewDetailShown.priority = .defaultHigh
                self.viewDetailHidden.priority = .defaultLow
                
                /// Remove Polyline
                self.polyline?.map = nil
            } else {
                self.viewDetailShown.priority = .defaultLow
                self.viewDetailHidden.priority = .defaultHigh
            }
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // MARK: - viewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addPlacesToMap()
    }
    
    func addPlacesToMap() {
        for Place in TopPlaces {
            let position = CLLocationCoordinate2D(
                latitude: Place.lat,
                longitude: Place.long
            )
            let marker = GMSMarker(position: position)
            marker.title = Place.name
            
            DispatchQueue.main.async {
                marker.map = self.mapView
            }
        }
    }
    
    func animateMapToLocation(latitude: Double, longitude: Double) {
        DispatchQueue.main.async {
            self.mapView.animate(
                to: GMSCameraPosition(
                    latitude: latitude,
                    longitude: longitude,
                    zoom: 17.0
                )
            )
        }
    }
    
    /// Just to animate map to places location
    /// Not required for you as living there
    /*
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateMapToLocation(
            latitude: TopPlaces[0].lat,
            longitude: TopPlaces[0].long
        )
    }
    */
}

// MARK: - Actions

extension HomeViewController {
    
    @IBAction func showDirections(_ sender: Any) {
        self.showDetailView(false)
        
        DispatchQueue.main.async {
            if let polypoints = self.polypoints {
                self.addPolyLine(encodedPath: polypoints)
            }
        }
    }
}

// MARK: - LocationManager

extension HomeViewController: LocationManagerDelegate {
    
    func locationManager(didUpdateLocation location: CLLocation) {
        slocation = location
        
        /// Animate map to user location
        animateMapToLocation(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
    }
}

// MARK: - MapViewDelegate

extension HomeViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        showDetailView(true)
        
        if let place = TopPlaces.first(
            where: { $0.name == marker.title }
        ) {
            populateDetailsWith(place: place)
        }
        
        return true
    }
    
    func populateDetailsWith(place: Place) {
        lblName.text = place.name
        lblTime.text = "calculating..."
        
        sPlace = place
        
        DispatchQueue.global(qos: .background).async {
            self.getDirections()
        }
    }
    
    func addPolyLine(encodedPath: String) {
        /// Remove Polyline
        polyline?.map = nil
        
        /// Render Polyline
        let path = GMSMutablePath(fromEncodedPath: encodedPath)
        polyline = GMSPolyline(path: path)
        polyline?.strokeWidth = 5
        polyline?.strokeColor = .orange
        polyline?.map = mapView
    }
    
    func addDuration(text: String) {
        lblTime.text = text + " by walk"
    }
}

// MARK: - API Call

extension HomeViewController {
    
    func getDirections() {
        guard let place = sPlace else {
            return
        }
        
        NetworkManager.sharedInstance.getDirections(
            sLatitude: slocation.coordinate.latitude,
            sLongitude: slocation.coordinate.longitude,
            dLatitude: place.lat,
            dLongitude: place.long,
            mode: .Walking
        ) { response in
            
            switch response.result {
            case .success(let value):
                
                if let directions = value as? [String:Any],
                   let arrRoutes = directions["routes"] as? [[String:Any]],
                   let routes = arrRoutes.first,
                   let overviewPolyline = routes["overview_polyline"] as? [String:Any],
                   let polypoints = overviewPolyline["points"] as? String {
                    self.polypoints = polypoints
                }
                
                if let directions = value as? [String:Any],
                   let arrRoutes = directions["routes"] as? [[String:Any]],
                   let routes = arrRoutes.first,
                   let arrLegs = routes["legs"] as? [[String:Any]],
                   let legs = arrLegs.first,
                   let duration = legs["duration"] as? [String:Any],
                   let text = duration["text"] as? String {
                    DispatchQueue.main.async {
                        self.addDuration(text: text)
                    }
                }
                
                break
                
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
