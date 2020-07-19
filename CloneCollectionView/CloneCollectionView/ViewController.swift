//
//  ViewController.swift
//  CloneCollectionView
//
//  Created by sapere4ude on 2020/07/19.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myCollectionView.delegate = self   // 위임자가 누구인지 알려주는 과정. 이벤트가 발생하면 프로토콜에 따라 연락을 주는 과정
        self.myCollectionView.dataSource = self
        self.myCollectionView.register(UINib(nibName: "MyCell", bundle: nil), forCellWithReuseIdentifier: "MyCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        self.myCollectionView.collectionViewLayout = layout
        self.myCollectionView.showsHorizontalScrollIndicator = false
        self.myCollectionView.showsVerticalScrollIndicator = false
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    // 이미 만들어져 있는 함수들을 가져와서 사용하는 것 & ViewController 클래스 생성 후 이러한 함수들만 따로 모아서 보기 쉽게 만들어 놓은 것
    // 선언부에는 Outlet이나 Action에 관련된 선언들만 모아두는 것이 좋다.
    // ViewController는 여리 프로토콜 중 이러한 것들을 채택한다는 의미 & 위에서 정의한 myCollectionView가 실행되면
    // 이곳의 함수들이 돌아가게 된다.
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let resultCnt = 5
        
        return resultCnt
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCell
        
        // myImgView 라는 것이 UI 에서 한개만 구현된 것이므로 하나의 UI를 돌려쓰는 형식을 취하고 있는 상황. 그렇기 때문에 조건을 주어 이미지가 변할 수 있게 만들어 주었다.
        if indexPath.row%2 == 0 {
            cell.myImgView.image = UIImage(named: "jun")
            cell.myLabel.text = "hello"
        }
        else {
            cell.myImgView.image = UIImage(named: "seung")
            cell.myLabel.text = "hi"
        }
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize: CGSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let edgeInsets: UIEdgeInsets = .init(top: 50, left: 0, bottom: 0, right: 0)
        
        return edgeInsets
    }
}
