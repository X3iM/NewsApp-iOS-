//
//  Article.swift
//  NewsApp
//
//  Created by Artem Hrynenko on 05.10.2022.
//

import Foundation

struct ArticleResponse: Codable {
    let articles: [Article]?
}

struct Article: Codable {
    let source: Source?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}

struct Source: Codable {
    let name: String?
}
