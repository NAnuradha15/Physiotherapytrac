//
//  LocationTrackerView.swift
//  COBSCComp212p-041
//
//  Created by Yesh Adithya on 2025-04-25.
//

import SwiftUI
import MapKit

struct LocationTrackerView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var searchText = ""

    var body: some View {
        VStack {
            HStack {
                TextField("Search", text: $searchText)
                    .padding(.vertical, 10)
                Button(action: {
                    locationManager.searchLocation(query: searchText)
                }) {
                    Image(systemName: "magnifyingglass")
                }
                Button(action: {
                    locationManager.region = MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: 6.9271, longitude: 79.8612),
                        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    )
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.white.opacity(0.9))
            )
            .padding(.bottom, 20)

            Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                .frame(height: 600)
                .cornerRadius(20)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.bgGray)
    }
}

#Preview {
    LocationTrackerView()
}
