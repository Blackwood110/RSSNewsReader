//
//  News.swift
//  RSSNews
//
//  Created by Александр Дергилёв on 11/10/2019.
//  Copyright © 2019 Александр Дергилёв. All rights reserved.
//

import UIKit

class News {
    var title: String
    var pubDate: String
    var imageURL: URL?
    var fullText: String
    var category: String
    
    init(title: String, pubDate: String, imageURL: URL?, fullText: String, category: String) {
        self.title = title
        self.pubDate = pubDate
        self.imageURL = imageURL
        self.fullText = fullText
        self.category = category
    }
}
