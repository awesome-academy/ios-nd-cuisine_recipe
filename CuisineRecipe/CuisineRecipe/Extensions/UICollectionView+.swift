//
//  UICollectionView+.swift
//  CuisineRecipe
//
//  Created by mac on 5/3/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

extension UICollectionView {
    func createLayoutCollectionView(viewSize: CGSize) {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: (viewSize.width) / 2, height: (viewSize.height - 32) / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 32
        self.collectionViewLayout = layout
    }
}
