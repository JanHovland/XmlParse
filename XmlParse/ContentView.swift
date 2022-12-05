//
//  ContentView.swift
//  XmlParse
//
//  Created by Jan Hovland on 05/12/2022.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @State var sunRises: [SunRise] = []
    @State var sunSets: [SunSet] = []
    
    var body: some View {
        VStack (alignment: .center, spacing: 0) {
            List(sunRises) { sunRise in
                Text(String(localized: "Sunrise: \(sunRise.time)"))
            }
            List(sunSets) { sunSet in
                Text(String(localized: "Sunset: \(sunSet.time)"))
            }
        }
        .task {
            let value : (String, [SunRise], [SunSet]) =
            await findSunInfo(url: "https://api.met.no/weatherapi/sunrise/2.0?",
                              latitude: 58.6173,
                              longitude: 5.6449,
                              offset: "+01:00",
                              days: 10)
            if value.0.isEmpty {
                sunRises = value.1
                sunSets = value.2
                
                print(sunSets[5].time)
                
            } else {
                sunRises.removeFirst()
                sunSets.removeAll()
            }
        }
    }
}

func findSunInfo(url: String,
                 latitude: Double,
                 longitude: Double,
                 offset: String,
                 days: Int) async -> (String, [SunRise], [SunSet]) {

    var sunRises: [SunRise] = []
    var sunSets: [SunSet] = []
    var errors : String = ""
   
    let date = FormatDateToString(date: Date(), format: "yyyy-MM-dd")
    let lat = "\(latitude)"
    let lon = "\(longitude)"
    let urlString = url + "lat=" + lat + "&lon=" + lon + "&date=" + date + "&offset=" + offset + "&days=" + String(days)
    let url = URL(string: urlString)
    print(url! as Any)

    /// Blanker sunRises:
    ///
    sunRises.removeAll()
    /// Blanker sunSets:
    ///
    sunSets.removeAll()
     
    /// Henter data fra filen test,xml:
    ///
    // if let url = Bundle.main.url(forResource: "test", withExtension: "xml") {
    
    if let url {
        do {
            /// Henter data fra filen test,xml:
            ///
            // let data = try Data(contentsOf: url)
            
            let urlSession = URLSession.shared
            let (data, _) = try await urlSession.data(from: url)
            
            let parser = SunParser(data: data)
            if parser.parse() {
                sunRises  = parser.sunRises
                sunSets  = parser.sunSets
            } else {
                errors = "\(String(describing: parser.parserError))"
            }
        } catch {
            errors = "\(error)"
        }
    }
    
    return (errors, sunRises, sunSets)
    
}
