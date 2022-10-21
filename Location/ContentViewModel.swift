//
//  ContentViewModel.swift
//  Location
//
//  Created by siuyunyip on 2022/10/20.
//

import MapKit

final class LocationManager: NSObject, ObservableObject {
    
    private var locationManager: CLLocationManager?
    let fileManager = LocalFileManager.instance
    var text: String = ""

    @Published var userLatitude: Double = 0
    @Published var userLongitude: Double = 0
    @Published var location: CLLocationCoordinate2D?
    @Published var region = MKCoordinateRegion.defaultRegion()
    
    func saveText() {
        fileManager.saveText(text)
        text = ""
    }
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager!.startUpdatingLocation()
//            locationManager!.allowsBackgroundLocationUpdates = true
//            locationManager!.showsBackgroundLocationIndicator = true
        } else {
            print("Location Service is off and go and turn it on.")
        }
    }
    
    func locationServiceEnabled() async -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
}

// have delegate listend for updates(e.g., user turn off the location service while using this app)
extension LocationManager: CLLocationManagerDelegate {
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        switch locationManager.authorizationStatus {
        // add for permission
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental control")
        case .denied:
            print("You have denied the location Service. Go into setting to change it")
        case .authorizedAlways, .authorizedWhenInUse:
            guard let location = locationManager.location else { return }
            region = MKCoordinateRegion(center: location.coordinate, span: MapDetails.defaultSpan)
        @unknown default:
            break
        }
    }
    
    // it would be automatically called when creating a location manager, and again when the app’s authorization changes.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        userLatitude = location.coordinate.latitude
        userLongitude = location.coordinate.longitude
        text.append("\(userLatitude), \(userLongitude)")
        text.append("\n")
        DispatchQueue.main.async {
            self.location = location.coordinate
            self.region = MKCoordinateRegion(center: location.coordinate, span: MapDetails.defaultSpan)
        }
    }
    
    func requestLocation() {
        locationManager?.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

