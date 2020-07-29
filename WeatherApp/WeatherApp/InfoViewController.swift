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
  
//        //let coor = locationManager.location?.coordinate
//        let latitude = 2323.1111
//        let longitude = 1323.4444
//
//        mapView = GMSMapView()
//        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 13.8)
//        mapView.camera = camera
//
//        mapView.settings.myLocationButton = true
//        mapView.isMyLocationEnabled = true
//        self.mapView.delegate = self
        
        
        
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//
//        let cord2D = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lon)!)
//
//        let marker = GMSMarker()
//        marker.position = cord2D
//        marker.title = "Location"
//        marker.snippet = "Australia"
//        marker.map = mapView
        
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        mapView.clear()
    }
    
    
    func converteKelvinToCelsius(input: Float) -> Float {
        return input - 273.5
    }
    
}
