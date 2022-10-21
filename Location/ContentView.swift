//
//  ContentView.swift
//  Location
//
//  Created by siuyunyip on 2022/10/20.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    @State var latilong = ""
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                .ignoresSafeArea()
                .accentColor(Color(.systemPink))
                .onAppear {
                    locationManager.checkIfLocationServicesIsEnabled()
                }
            
            VStack {
                Text("Current Location: \(locationManager.userLatitude), \(locationManager.userLongitude)")
                    .font(.callout)
                    .foregroundColor(.white)
                    .padding()
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
            }
            .position(x:182, y:20)
            .padding()
            
            VStack {
                Button {
                    locationManager.saveText()
                } label: {
                    Text("Save")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.blue)
                        .cornerRadius(10)
                }

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
