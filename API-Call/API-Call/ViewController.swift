//
//  ViewController.swift
//  API-Call
//
//  Created by Kant on 2023/08/26.
//

import UIKit
import RxSwift
import Combine

class CommonURL {
    static let NEWS_URL = "https://newsapi.org/v2/top-headlines?country=kr&apiKey=4927a1a645a249c489e248bf460cf4b4"
    static let NEWS_MENTIONING_APPLE_URL = "https://newsapi.org/v2/everything?q=apple&from=2023-08-25&to=2023-08-25&sortBy=popularity&apiKey=4927a1a645a249c489e248bf460cf4b4"
    static let NEWS_ABOUT_TESLA_URL = "https://newsapi.org/v2/everything?q=tesla&from=2023-07-26&sortBy=publishedAt&apiKey=4927a1a645a249c489e248bf460cf4b4"
}

class ViewController: UIViewController {
    
    @IBOutlet weak var apiCallTitle: UILabel!
    @IBOutlet weak var apiResultLabel: UILabel!
    
    let disposeBag = DisposeBag()
    var cancellabels = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapDefaultButton(_ sender: Any) {

        if let url = URL(string: CommonURL.NEWS_URL) {
            DefaultCall().fetchArticles(url: url) { articles in
                if let articles = articles {
                    self.showResult(title: "Default Call", context: "\(articles)")
                }
            }
        }
    }
    
    @IBAction func tapRxSwiftButton(_ sender: Any) {
        if let url = URL(string: CommonURL.NEWS_MENTIONING_APPLE_URL) {
            RxCall().fetchArticles(url: url)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { articles in
                    self.showResult(title: "RxSwift Call", context: "\(articles)")
                })
                .disposed(by: disposeBag)
        }
    }
    
    @IBAction func tapCombineButton(_ sender: Any) {
        if let url = URL(string: CommonURL.NEWS_ABOUT_TESLA_URL) {
            CombineCall().fetchArticles(url: url)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { _ in
                    
                }, receiveValue: { articles in
                    self.showResult(title: "Combine Call", context: "\(articles)")
                })
                .store(in: &cancellabels)
        }
    }
    
    private func showResult(title: String, context: String) {
        DispatchQueue.main.async {
            self.apiCallTitle.text = title
            self.apiResultLabel.text = context
        }
    }
}

