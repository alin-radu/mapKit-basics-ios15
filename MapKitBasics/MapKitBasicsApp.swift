//
//  MapKitBasicsApp.swift
//  MapKitBasics
//
//  Created by Alin RADU on 08.03.2024.
//

import SwiftUI

@main
struct MapKitBasicsApp: App {
    @StateObject private var viewModel = LocationsView.ViewModel()

    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(viewModel)
        }
    }
}
