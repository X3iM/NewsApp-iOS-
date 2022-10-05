//
//  NewsTableViewCellViewModel.swift
//  NewsApp
//
//  Created by Artem Hrynenko on 05.10.2022.
//

import Foundation

class NewsTableViewCellViewModel {
    let title: String
    let subtitle: String
    let imageUrl: URL?
    var imageData: Data? = nil
    
    init(title: String, subtitle: String, imageUrl: URL?) {
        self.title = title
        self.subtitle = subtitle
        self.imageUrl = imageUrl
    }
    
}
