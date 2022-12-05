//
//  ContentView.swift
//  XmlParse
//
//  Created by Jan Hovland on 05/12/2022.
//

import Foundation
import SwiftUI

struct SunRise: Identifiable {
    let id = UUID()
    var time: String
}

struct SunSet: Identifiable {
    let id = UUID()
    var time: String
}

struct ContentView: View {
    @State var sunRises: [SunRise] = []
    @State var sunSets: [SunSet] = []
    
    var body: some View {
        VStack (alignment: .center, spacing: 0) {
            List(sunRises) { sunRise in
                Text("Sunrise : \(sunRise.time)")
            }
            List(sunSets) { sunSet in
                Text("Sunset: \(sunSet.time)")
            }
        }
        .task {
            // if let url = Bundle.main.url(forResource: "test", withExtension: "xml") {
            if let url = URL(string: "https://api.met.no/weatherapi/sunrise/2.0?lat=58.6173&lon=5.644916&date=2022-12-04&offset=+01:00&days=10") {
                do {
                    // let data = try Data(contentsOf: url)
                    let urlSession = URLSession.shared
                    let (data, _) = try await urlSession.data(from: url)
                    
                    let parser = SunParser(data: data)
                    if parser.parse() {
                        sunRises  = parser.sunRises
                        sunSets  = parser.sunSets
                    } else {
                        print("\n---> parser error: \(parser.parserError as Optional)")
                    }
                } catch {
                    print("\n---> data error: \(error)")
                }
            }
        }
    }
}
