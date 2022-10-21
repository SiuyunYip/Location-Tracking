//
//  RegionExtension.swift
//  Location
//
//  Created by zerenyip on 2022/10/20.
//

import MapKit

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 53.3438778, longitude: -6.257445)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
}

extension MKCoordinateRegion {
    static func defaultRegion() -> MKCoordinateRegion {
        // center: the location ur in
        // span: how zoomed in we want to be
        return MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
    }
}

