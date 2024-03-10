//
//  LocationDetailView.swift
//  MapKitBasics
//
//  Created by Alin RADU on 10.03.2024.
//

import MapKit
import SwiftUI

struct LocationDetailView: View {
    @EnvironmentObject private var viewModel: LocationsView.ViewModel

    let location: Location

    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(color: /*@START_MENU_TOKEN@*/ .black/*@END_MENU_TOKEN@*/ .opacity(0.3), radius: 20, x: 0, y: 10)

                VStack(alignment: .leading, spacing: 16) {
                    titleSection

                    Divider()

                    descriptionSection

                    Divider()

                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(backButton, alignment: .topLeading)
    }
}

#Preview {
    LocationDetailView(location: Location.example)
        .environmentObject(LocationsView.ViewModel())
}

extension LocationDetailView {
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .containerRelativeFrame(.horizontal) { size, _ in
                        size * 1
                    }
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }

    private var backButton: some View {
        Button {
            viewModel.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.body)
                .fontWeight(.semibold)
                .padding(8)
                .foregroundStyle(.primary)
                .background(RoundedRectangle(cornerRadius: 10)
                    .fill(.thickMaterial)
                    .shadow(radius: 4)
                )
                .padding()
        }
    }

    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)

            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }

    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(location.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            if let url = URL(string: location.link) {
                Link("Read more on Wikipedia", destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
        }
    }

    private var mapLayer: some View {
        Map(initialPosition:
            .camera(MapCamera(centerCoordinate: location.coordinates, distance: 1000, heading: 400, pitch: 50))) {
                Annotation(location.name, coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .shadow(radius: 10)
                        .scaleEffect(0.5)
                        .padding(.bottom, 75)
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .clipShape(.rect(cornerRadius: 30))
            .allowsHitTesting(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
    }
}
