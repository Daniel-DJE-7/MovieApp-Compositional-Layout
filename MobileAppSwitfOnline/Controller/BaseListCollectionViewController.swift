//
//  BaseListCollectionViewController.swift
//  MobileAppSwitfOnline
//
//  Created by Memo Figueredo on 13/3/26.
//

import UIKit



class BaseListCollectionViewController: UICollectionViewController {
  //    pass view to tabBar to UICollectionViewController
  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
