//
//  LocationView.swift
//  MapApp
//
//  Created by Alin RADU on 07.03.2024.
//

import MapKit
import SwiftUI

struct LocationsView: View {
    @EnvironmentObject private var viewModel: ViewModel
    let maxWidthForIpad: CGFloat = 700

    var body: some View {
        ZStack {
            mapLayer

            VStack(spacing: 0) {
                header
                    .padding()
                    .frame(maxWidth: maxWidthForIpad)

                Spacer()

                locationsPreviewStack
            }
        }
        .sheet(item: $viewModel.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsView.ViewModel())
}

extension LocationsView {
    private var mapLayer: some View {
        Map(position: $viewModel.mapRegion) {
            ForEach(viewModel.locations) { location in
                Annotation(location.name, coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .scaleEffect(viewModel.mapLocation == location ? 1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            viewModel.showNextLocation(location: location)
                        }
                }
            }
        }
    }

    private var header: some View {
        VStack {
            Button {
                viewModel.toggleLocationsList()
            } label: {
                Text(viewModel.mapLocation.name + ", " + viewModel.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: viewModel.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: viewModel.showLocationsList ? 180 : 0))
                    }
            }

            if viewModel.showLocationsList {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 15)
    }

    private var locationsPreviewStack: some View {
        // LocationPreviewView(location: viewModel.mapLocation)
        //     .shadow(color: .black.opacity(0.3), radius: 20)
        //     .padding()
        //     .frame(maxWidth: maxWidthForIpad)
        //     .frame(maxWidth: .infinity)
        //     .transition(.asymmetric(
        //         insertion: .move(edge: .trailing),
        //         removal: .move(edge: .leading)))
        ZStack {
            ForEach(viewModel.locations) { location in
                if viewModel.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: .black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
}
