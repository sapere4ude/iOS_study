//
//  CombineCall.swift
//  API-Call
//
//  Created by Kant on 2023/08/26.
//

import Foundation
import Combine

class CombineCall {
    
    func fetchArticles(url: URL) -> AnyPublisher<[Article], Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httppResponse = response as? HTTPURLResponse,
                      httppResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: ArticleList.self, decoder: JSONDecoder())
            .map { $0.articles }
            .eraseToAnyPublisher()
    }
}
