//
//  ViewController.swift
//  MapKitLab
//
//  Created by Gregory Keeley on 2/24/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    private let locationSession = CoreLocationSession()
    private var userTrackingButton: MKUserTrackingButton!
    private var annotations = [MKPointAnnotation]()
    
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
}

