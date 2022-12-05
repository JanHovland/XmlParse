//
//  SunInfo.swift
//  XmlParse
//
//  Created by Jan Hovland on 05/12/2022.
//

import Foundation

struct SunRise: Identifiable {
    let id = UUID()
    var time = String()
}

struct SunSet: Identifiable {
    let id = UUID()
    var time = String()
}
