//
//  Location.swift
//  MapApp
//
//  Created by Alin RADU on 07.03.2024.
//

import Foundation
import MapKit

struct Location: Equatable, Identifiable {
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String

    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }

    var id: String {
        name + cityName
    }

    #if DEBUG
        static let example = Location(
            name: "Colosseum",
            cityName: "Rome",
            coordinates: CLLocationCoordinate2D(latitude: 41.8902, longitude: 12.4922),
            description: "The Colosseum is an oval amphitheatre in the centre of the city of Rome, Italy, just east of the Roman Forum. It is the largest ancient amphitheatre ever built, and is still the largest standing amphitheatre in the world today, despite its age.",
            imageNames: [
                "rome-colosseum-1",
                "rome-colosseum-2",
                "rome-colosseum-3",
            ],
            link: "https://en.wikipedia.org/wiki/Colosseum")
    #endif
}
