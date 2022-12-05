//
//  SunParser.swift
//  XmlParse
//
//  Created by Jan Hovland on 05/12/2022.
//

import Foundation

class SunParser: XMLParser {
    var sunRises: [SunRise] = []
    var sunSets: [SunSet] = []
    
    override init(data: Data) {
        super.init(data: data)
        self.delegate = self
    }
}

extension SunParser: XMLParserDelegate {
    
    // Called when opening tag (`<elementName>`) is found
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        switch elementName {
            
        case "sunrise":
            let sunRise = SunRise(
                time:  attributeDict["time"] ?? "")
            sunRises.append(sunRise)
            
        case "sunset":
            let sunSet = SunSet(
                time:  attributeDict["time"] ?? "")
            sunSets.append(sunSet)
            
        default: break
            
        }
    }
    
    // Called when closing tag (`</elementName>`) is found
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //...
    }
    
    // Called when a character sequence is found
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //...
    }
    
    // Called when a CDATA block is found
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        guard String(data: CDATABlock, encoding: .utf8) != nil else {
            print("CDATA contains non-textual data, ignored")
            return
        }
    }
}

