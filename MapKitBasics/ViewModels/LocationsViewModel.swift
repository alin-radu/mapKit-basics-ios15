//
//  LocationsViewModel.swift
//  MapKitBasics
//
//  Created by Alin RADU on 08.03.2024.
//

import MapKit
import SwiftUI

extension LocationsView {
    class ViewModel: ObservableObject {
        // all loaded locations
        @Published var locations: [Location]
        // current location
        @Published var mapLocation: Location {
            didSet {
                updateMapRegion(location: mapLocation)
            }
        }

        // current region
        @Published var mapRegion: MapCameraPosition

        // show list of locations
        @Published var showLocationsList: Bool = false

        // show location detail via sheet
        @Published var sheetLocation: Location? = nil

        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

        init() {
            let locations = LocationsDataService.locations
            let firstLocation = locations.first!

            self.locations = locations
            mapLocation = firstLocation
            mapRegion = MapCameraPosition.region(
                MKCoordinateRegion(
                    center: firstLocation.coordinates,
                    span: mapSpan)
            )
        }

        private func updateMapRegion(location: Location) {
            withAnimation(.easeInOut) {
                mapRegion = MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: location.coordinates,
                        span: mapSpan)
                )
            }
        }

        func toggleLocationsList() {
            withAnimation(.easeInOut) {
                showLocationsList.toggle()
            }
        }

        func showNextLocation(location: Location) {
            withAnimation(.easeInOut) {
                mapLocation = location
                showLocationsList = false
            }
        }

        func nextButtonPressed() {
            // get the current index
            // let currentIndex = locations.firstIndex { $0 == mapLocation }

            guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
                print("Could not found current index in locations array! Should never happen.")
                return
            }

            // check if the index is valid, is not the last item
            let nextIndex = currentIndex + 1
            guard locations.indices.contains(nextIndex) else {
                // next index is not valid
                // restart from 0
                guard let firstLocation = locations.first else { return }
                showNextLocation(location: firstLocation)
                return
            }

            // next index is valid
            if locations.contains(locations[nextIndex]) {
                let nextLocation = locations[nextIndex]
                showNextLocation(location: nextLocation)
            }
        }
    }
}
