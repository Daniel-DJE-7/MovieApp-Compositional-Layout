//
//  TitleHeaderCollectionReusableView.swift
//  MobileAppSwitfOnline
//
//  Created by Memo Figueredo on 11/4/26.
//

import UIKit

class TitleHeaderCollectionReusableView: UICollectionReusableView {
        
  static let identifier = "TitleHeaderCollectionReusableView"
  
  private let headerlabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = .systemFont(ofSize: 18, weight: .semibold)
    label.numberOfLines = 1
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBackground
    addSubview(headerlabel)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    headerlabel.frame = CGRect(x: 10, y: 0, width: 70, height: 40)
    
  }
  
  //MARK: - Configure title
  func configure(with title: String) {
    headerlabel.text = title
  }
}
