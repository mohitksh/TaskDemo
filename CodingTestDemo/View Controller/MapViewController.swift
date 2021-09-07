//
//  MapViewController.swift
//  CodingTestDemo
//
//  Created by Mohit Kumar on 07/09/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    private let locationManager = LocationManager()
    
    var selectedCity = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLocationAuthorization()
        
        mapView.delegate = self
    }
    
    //MARK:-  LOCATION PERMISSION CHECK
    func checkLocationAuthorization() {
      switch CLLocationManager.authorizationStatus() {
      case .authorizedWhenInUse:
        getLatLong()
        mapView.showsUserLocation = true
       case .denied: // Show alert telling users how to turn on permissions
       break
      case .notDetermined:
        mapView.showsUserLocation = true
      case .restricted: // Show an alert letting them know what’s up
       break
      case .authorizedAlways:
        getLatLong()
       break
      }
    }
    
  
    
    //MARK:- METHOD FOR GET LOCATION FROM CITY NAME
    func getLatLong() {
        self.locationManager.getLocation(forPlaceCalled: selectedCity) { location in
            guard let location = location else { return }
            
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            print("region >>>>  \(region)")
            
            self.marker(lat: region.center.latitude, long: region.center.longitude)
        }
    }
    
    
    //MARK:- METHOD FOR SET MARKER ON LOCATION
    func marker(lat: Double, long: Double) {
        let annotations = MKPointAnnotation()
        annotations.title = selectedCity
        annotations.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        mapView.addAnnotation(annotations)
        setFocus(lat: lat, long: long)
    }
    
    
    //MARK:- METHOD FOR SET FOCUS ON LOCATION
    func setFocus(lat: Double, long: Double) {
        let dortmundLocation = CLLocation(latitude: lat, longitude: long)
        let dortmunRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: dortmundLocation.coordinate.latitude, longitude: dortmundLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(dortmunRegion, animated: true)
    }
    
  
}


//MARK:- MAPKIT DELEGATE FUNCTION
extension MapViewController: MKMapViewDelegate {
   
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
           let identifier = "artwork"
           var view: MKMarkerAnnotationView
           if let dequeuedView = mapView.dequeueReusableAnnotationView(
             withIdentifier: identifier) as? MKMarkerAnnotationView {
             dequeuedView.annotation = annotation
             view = dequeuedView
           } else {
             view = MKMarkerAnnotationView(
               annotation: annotation,
               reuseIdentifier: identifier)
             view.canShowCallout = true
             view.calloutOffset = CGPoint(x: -5, y: 5)
             view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
           }
           return view
    }

   func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
      print("calloutAccessoryControlTapped")
    
   }

   func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
      print("didSelectAnnotationTapped")
   }
}
