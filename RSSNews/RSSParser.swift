//
//  RSSParser.swift
//  RSSNews
//
//  Created by Александр Дергилёв on 13/10/2019.
//  Copyright © 2019 Александр Дергилёв. All rights reserved.
//

import UIKit

protocol RSSParserProtocol: class {
    func parsingWasFinish()
}

class RSSParser: NSObject, XMLParserDelegate {
    var newsArray:[News] = []
    var tempNews: News? = nil
    var tempElement: String?
    
    var delegate: RSSParserProtocol?
    
    func startParsingWithContentsOfURL(rssURL: URL) {
        let parser = XMLParser(contentsOf: rssURL)
        parser?.delegate = self
        parser?.parse()
    }
    
    // MARK - XMLParserDelegate
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        tempElement = elementName
        if elementName == "item" {
            tempNews = News(title: "", pubDate: "", imageURL: nil, fullText: "", category: "")
        }
        if elementName == "enclosure" {
            if let urlString = attributeDict["url"] {
                let url = URL(string: urlString)
                tempNews?.imageURL = url
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if let news = tempNews {
            if tempElement == "title" {
                tempNews?.title = news.title + string
            } else if tempElement == "pubDate" {
                tempNews?.pubDate = news.pubDate + string
            } else if tempElement == "category" {
                tempNews?.category = news.category + string
            } else if tempElement == "yandex:full-text" {
                tempNews?.fullText = news.fullText + string
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            if let news = tempNews {
                newsArray.append(news)
            }
            tempNews = nil
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        delegate?.parsingWasFinish()
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
    
    func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        print(validationError.localizedDescription)
    }
}

