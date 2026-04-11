//
//  PopularActorsCollectionViewCell.swift
//  MobileAppSwitfOnline
//
//  Created by Memo Figueredo on 3/4/26.
//

import UIKit

class PopularActorsCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "PopularActorsCollectionViewCell"
  
  
  //MARK: - image of actors
  private let imageActors: UIImageView = {
    let image = UIImageView()
    image.backgroundColor = .systemBlue
    image.contentMode = .scaleAspectFill
    image.widthAnchor.constraint(equalToConstant: 140).isActive = true
    image.heightAnchor.constraint(equalToConstant: 200).isActive = true
    return image
  }()
  
  
  private let nameActorsLabel: UILabel = {
    let label = UILabel()
    label.text = "name"
    label.tintColor = .black
    label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let imageAndNameStack = UIStackView(arrangedSubviews: [
      imageActors, nameActorsLabel
    ])
    imageAndNameStack.axis = .vertical
    imageAndNameStack.spacing = 10
    imageAndNameStack.fillSuperview(padding: .init(top: 15, left: 15, bottom: 15, right: 15))
    addSubview(imageAndNameStack)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with model: Cast) {
    let baseUrl = "https://image.tmdb.org/t/p/w500"
    
    guard let path = model.profilePath,
          let url = URL(string: baseUrl + path) else {
      return
    }
    imageActors.kf.indicatorType = .activity
    imageActors.kf.setImage(with: url, options: [
      .cacheOriginalImage
    ])
    nameActorsLabel.text = model.name
  }
}
