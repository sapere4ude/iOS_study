//
//  RxCall.swift
//  API-Call
//
//  Created by Kant on 2023/08/26.
//

import Foundation
import RxSwift

class RxCall {
    
    func fetchArticles(url: URL) -> Observable<[Article]> {
        return Observable<[Article]>.create { observer in
            let task = URLSession.shared.dataTask(with: url) {
                data, response, error in
                guard error == nil else {
                    return observer.onError(error!)
                }
                
                if let data = data {
                    do {
                        let articleList = try JSONDecoder().decode(ArticleList.self, from: data)
                        observer.onNext(articleList.articles)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }

                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
