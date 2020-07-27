//
//  ViewController.swift
//  WeatherApp
//
//  Created by sapere4ude on 2020/07/25.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import SwiftyJSON
import GoogleMaps

class ViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    /* 저장 프로퍼티 생성
    구조체의 저장 프로퍼티가 옵셔널이 아니더라도, 구조체는 저장 프로퍼티를 모두 포함하는 이니셜라이저를 자동으로 생성한다.
    하지만 클래스의 저장 프로퍼티는 옵셔널이 아니라면 프로퍼티 기본값을 지정해주거나 사용자정의 이니셜라이저를 통해 반드시 초기화해주어야 합니다.
     */
    var weatherQueryInfoArr: Array<Any>? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherQueryInfoArr = readJsonFile()
        initUI()
        
        
    }
    
    func initUI() {
        self.backgroundView.backgroundColor = .clear
        self.tableView.delegate = self      // extension 확인
        self.tableView.dataSource = self    // extension 확인
        self.tableView.register(UINib(nibName: "MyCell", bundle: nil), forCellReuseIdentifier:"MyCell")
    }
    
    func readJsonFile() -> Array<Any> {
        var resultArr: Array = Array<Any>()
        
        if let path = Bundle.main.path(forResource: "cityList", ofType: "json"){
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                resultArr = try (JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! Array<Any>)
            } catch {
                print("json 파일 읽기 실패")
            }
        }
        return resultArr
    }

}



extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherQueryInfoArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
        let data: Dictionary? = weatherQueryInfoArr?[indexPath.row] as? [String: Any]
        cell.data = data
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = weatherQueryInfoArr![indexPath.row] as! [String:Any]
        let id: String = String(data["id"]! as! Int)
        let url = CommonDefine.apiAddr + "?id=" + id + "&appid=" + CommonDefine.apiKey
        print("")
        
        ApiManager.query(url: url,
                         function: .get,
                         header: nil,
                         param: nil,
                         requestType: .json,
                         responseType: .json,
                         timeout: 60,
                         completeHandler: { (responseData) in
            let myJson: JSON = try! JSON(data: responseData)
            DispatchQueue.main.async{
                let vc = InfoViewController(nibName: "InfoViewController", bundle: nil)
                vc.data = myJson
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }) { (err) in
            // 얼럿 띄우기
            print("err:\(err.localizedDescription)")
        }
        
    // 로딩뷰 띄우기
    func displaySpinner(onView: UIView) -> UIView {
            let spinnerView = UIView.init(frame: onView.bounds)
            spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
            
            let ai = UIActivityIndicatorView.init(style: .whiteLarge)
            ai.startAnimating()
            ai.center = spinnerView.center
            
            DispatchQueue.main.sync {
                spinnerView.addSubview(ai)
                onView.addSubview(spinnerView)
            }
            
            return spinnerView
        }
        
    func removeSpinner(spinner: UIView){
            DispatchQueue.main.sync {
                spinner.removeFromSuperview()
            }
        }
    }
}
