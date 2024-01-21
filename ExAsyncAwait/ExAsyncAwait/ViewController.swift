//
//  ViewController.swift
//  ExAsyncAwait
//
//  Created by Kant on 1/20/24.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 하나의 묶음으로 처리해준다는 의미로 Task 블럭으로 감싸준다
        Task {
            await performAsyncTask() // async 한 함수이기 때문에 반드시 함수명 앞에 await 키워드가 붙어줘야함
        }
    }
    
    // 함수명에 async 를 넣어서 비동기 작업으로 이뤄지는 함수라는걸 명시
    func fetchSampleData() async throws -> [SampleData] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let sampleData = try JSONDecoder().decode([SampleData].self, from: data)
        return sampleData
    }
    
    func performAsyncTask() async {
        do {
            let data = try await fetchSampleData()
            print("result: \(data)")
        } catch {
            
        }
    }
}

struct SampleData: Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}

