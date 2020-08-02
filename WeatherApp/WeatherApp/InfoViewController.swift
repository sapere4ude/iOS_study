//
//  InfoViewController.swift
//  WeatherApp
//
//  Created by sapere4ude on 2020/07/26.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData
import GoogleMaps

// todo 구글지도로 마커찍기
class InfoViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    //todo 디자인하기
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    
    var lat = ""
    var lon = ""
    
    var data: JSON = JSON.null {
        didSet {
            print("data: \(data)")
            print("test: \(data["main"]["temp_min"].intValue)")
            
            lat = data["coord"]["lat"].stringValue
            lon = data["coord"]["lon"].stringValue
            
            print("lat: \(lat)")
            print("lon: \(lon)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        label.text = String(converteKelvinToCelsius(input: data["main"]["temp_min"].floatValue))
        
        //추가
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        
        self.mapView = mapView
        
        let cord2D = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lon)!)
        let marker = GMSMarker()
        marker.position = cord2D
        marker.title = "Location"
        marker.snippet = "Australia"
        marker.map = mapView
        print("check")
        
        //        let camera = GMSCameraPosition.camera(withLatitude: 28.7041, longitude: 77.1025, zoom: 6.0)
        //        google_map.camera = camera
        //        self.show_marker(position: google_map.camera.target)
        
        
        
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        mapView.clear()
    }
    
    //
    //        func show_marker(position: CLLocationCoordinate2D){
    //        let marker = GMSMarker()
    //        marker.position = position
    //        marker.title = "Delhi"
    //        marker.snippet = "Capital of India"
    //        marker.map = google_map
    //    }
    
    
    
    
    
    func converteKelvinToCelsius(input: Float) -> Float {
        return input - 273.5
    }
    
}
