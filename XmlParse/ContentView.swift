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
            if let url = Bundle.main.url(forResource: "test", withExtension: "xml") {
                do {
                    let data = try Data(contentsOf: url)
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
