//
//  LocationsListView.swift
//  MapKitBasics
//
//  Created by Alin RADU on 08.03.2024.
//

import SwiftUI

struct LocationsListView: View {
    @EnvironmentObject private var viewModel: LocationsView.ViewModel

    var body: some View {
        LazyVStack {
            Divider()

            ForEach(viewModel.locations) { location in

                if location == viewModel.mapLocation {
                    EmptyView()
                } else {
                    Button {
                        viewModel.showNextLocation(location: location)
                    } label: {
                        listRowView(location: location)
                    }
                    .padding(.vertical, 4)
                    .listRowBackground(Color.clear)

                    Divider()
                }
            }
        }
        .listStyle(.plain)
        .padding(.horizontal, 12)
    }
}

#Preview {
    LocationsListView()
        .environmentObject(LocationsView.ViewModel())
}

extension LocationsListView {
    private func listRowView(location: Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .clipShape(.rect(cornerRadius: 10))
            }

            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.primary)
        }
    }
}
