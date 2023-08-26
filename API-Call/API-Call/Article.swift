//
//  Article.swift
//  API-Call
//
//  Created by Kant on 2023/08/26.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String?
    let description: String?
}
