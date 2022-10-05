//
//  APICaller.swift
//  NewsApp
//
//  Created by Artem Hrynenko on 05.10.2022.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    fileprivate struct Constants {
        static let apiKey = "a91e160714d14003a88d02d8dc1fb732"
        
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?category=general&language=en&apiKey=\(apiKey)")
    }
    
    private init() {}
    
    public func getTopStories(completion: @escaping (Result<[Article]?, Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(ArticleResponse.self, from: data)
                    print("Articles: \(result.articles?.count)")
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}
