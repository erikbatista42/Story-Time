//
//  ExploreCV.swift
//  Vlogr
//
//  Created by Erik Batista on 1/27/18.
//  Copyright © 2018 kennybatista. All rights reserved.
//

import UIKit

class ExploreCV: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let cellId = "cellId"
    
    var colView: UICollectionView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 111, height: 111)
        
        colView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        colView.delegate   = self
        colView.dataSource = self
        colView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        colView.backgroundColor = UIColor.white
        
        self.view.addSubview(colView)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath)
        cell.backgroundColor = UIColor.orange
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (view.frame.width - 2) / 3
//        return CGSize(width: width, height: 189)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
    

}