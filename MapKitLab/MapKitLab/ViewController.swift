//
//  ViewController.swift
//  MapKitLab
//
//  Created by Gregory Keeley on 2/24/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit
import MapKit
import NetworkHelper

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    private let locationSession = CoreLocationSession()
    private var userTrackingButton: MKUserTrackingButton!
    private var annotations = [MKPointAnnotation]()
    
    private var publicSchools = [PublicSchool]() {
        didSet {
            dump(self.publicSchools)
           annotations = loadSchoolAnnotations()
            mapView.addAnnotations(annotations)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        userTrackingButton = MKUserTrackingButton(frame: CGRect(x: 20, y: 50, width: 40, height: 40))
        userTrackingButton.mapView = mapView
        userTrackingButton.backgroundColor = .link
        userTrackingButton.tintColor = .blue
        userTrackingButton.layer.cornerRadius = 4
        mapView.addSubview(userTrackingButton)
        loadMap()
        getSchools()
    }
    private func makeAnnotations() -> [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        for location in Location.getLocations() {
        let annotation = MKPointAnnotation()
            annotation.title = location.title
            annotation.coordinate = location.coordinate
            annotations.append(annotation)
        }
        self.annotations = annotations
        return annotations
    }
    private func loadMap() {
        let annotations = makeAnnotations()
        mapView.addAnnotations(annotations)
    }
    
    private func getSchools() {
        GenericCoderAPI.manager.getJSON(objectType: [PublicSchool].self, with: "https://data.cityofnewyork.us/resource/uq7m-95z8.json") { (results) in
            switch results {
            case .failure(let appError):
                print("error: \(appError)")
            case .success(let schoolData):
                DispatchQueue.main.async {
                self.publicSchools = schoolData
                }
            }
        }
    }
    private func loadSchoolAnnotations() -> [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        for school in publicSchools {
            let annotation = MKPointAnnotation()
            let latitude = Double(school.latitude)!
            let longitude = Double(school.longitude)
            let schoolCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude!)
            annotation.coordinate = schoolCoordinate
            annotation.title = school.schoolName
            annotations.append(annotation)
        }
        return annotations
    }
}
extension ViewController: MKMapViewDelegate {
    
}
