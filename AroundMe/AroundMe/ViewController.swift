//
//  ViewController.swift
//  AroundMe
//
//  Created by Iman Zarrabian on 22/09/2017.
//  Copyright © 2017 One More Thing Studio. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var alert: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        
        locationManager.delegate = self
        
    }
    
    func delayUserLocationDisplay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.setRegionAroundMe()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func setRegionAroundMe() {
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
    }
}


extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedWhenInUse:
          /*  if let alert = alert {
                alert.dismiss(animated: true, completion: nil)
            }*/
            delayUserLocationDisplay()
        case .denied:
            //Display error
            alert = UIAlertController(title: "Oops", message: "ça marchera mieux avec le GPS", preferredStyle: .alert)
            
            let dismissAction = UIAlertAction(title: "Go to Setting", style: .destructive, handler: { (action) in
                //dismiss + redirige vers settings
                self.alert!.dismiss(animated: true, completion: nil)
                self.goToSettingsApp()
            })
            
            let doNothingAction = UIAlertAction(title: "Ok thx, but no thx", style: .cancel, handler: { (action) in
                self.alert!.dismiss(animated: true, completion: nil)
            })
                
            alert?.addAction(dismissAction)
            alert?.addAction(doNothingAction)

            present(alert!, animated: true, completion: nil)
        default:
            break
        }
    }
    
    func goToSettingsApp() {
        let settingsUrl = URL(string: UIApplicationOpenSettingsURLString)
        if let url = settingsUrl {
          //  UIApplication.shared.openURL(url)
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

