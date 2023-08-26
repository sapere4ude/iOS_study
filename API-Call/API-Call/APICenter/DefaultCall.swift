//
//  Default.swift
//  API-Call
//
//  Created by Kant on 2023/08/26.
//

import Foundation

class DefaultCall {
    
    func fetchArticles(url: URL, completion: @escaping ([Article]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("Error:\(String(describing: error?.localizedDescription))")
                return completion(nil)
            }
            
            if let data = data {
                let articleList = try? JSONDecoder().decode(ArticleList.self, from: data)
                
                if let articleList = articleList {
                    completion(articleList.articles)
                }
            }
        }.resume()
    }
}
