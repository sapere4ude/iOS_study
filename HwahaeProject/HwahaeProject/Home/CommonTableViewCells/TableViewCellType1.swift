//
//  TableViewCellType1.swift
//  HwahaeProject
//
//  Created by sapere4ude on 2020/08/10.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import SwiftyJSON

class TableViewCellType1: UITableViewCell {
    
    //MARK: IBOutlet
    
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreBtnView: UIView!
    @IBOutlet weak var moreBtnImgView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: property
    
    var infoData:JSON = JSON.null {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    //MARK: function
    
    func initUI() {
        self.mainContainerView.backgroundColor = .white
        self.topContainerView.backgroundColor = .clear
        self.moreBtnView.backgroundColor = .clear
        self.moreBtnImgView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(moreViewAction(_:)))
        self.moreBtnImgView.addGestureRecognizer(tapGesture)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "CollectionViewCellType1", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCellType1")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        self.collectionView.collectionViewLayout = layout
        self.collectionView.showsHorizontalScrollIndicator = false
    }
    
    //MARK: action
 
    @objc func moreViewAction(_ sender: UITapGestureRecognizer) {
        print("버튼 클릭")
    }
    
}

extension TableViewCellType1:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.infoData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data:JSON = self.infoData[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellType1", for: indexPath) as! CollectionViewCellType1
        cell.infoData = data
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize:CGSize = CGSize(width: 150, height: 150)
        
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let edgeInsets:UIEdgeInsets = .init(top: 5,
                                            left: 10,
                                            bottom: 5,
                                            right: 10)
        return edgeInsets
    }
    
    
}
