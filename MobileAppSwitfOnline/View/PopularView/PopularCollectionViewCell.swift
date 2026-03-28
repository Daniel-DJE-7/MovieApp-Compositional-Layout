//
//  PopularCollectionViewCell.swift
//  MobileAppSwitfOnline
//
//  Created by Memo Figueredo on 24/3/26.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {

  static let identifier = "PopularCollectionViewCell"
  
  //MARK: Image movie
  private let imageMovie: UIImageView = {
    let image = UIImageView()
    image.layer.cornerRadius = 10
    image.clipsToBounds = true
    image.backgroundColor = #colorLiteral(red: 0.004859850742, green: 0.1429360474, blue: 0.2692385255, alpha: 1)
    image.widthAnchor.constraint(equalToConstant: 200).isActive = true
    image.heightAnchor.constraint(equalToConstant: 250).isActive = true
    image.contentMode = .scaleAspectFill
    return image
  }()
  
  //MARK: StarIcon Image
  private let starIconImage: UIImageView = {
    let imageIcon = UIImageView()
    imageIcon.image = UIImage(systemName: "star.fill")
    imageIcon.tintColor = .systemYellow
    return imageIcon
  }()
  
  //MARK: TitleMovieLabel
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "APP MOVIE"
    label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    label.textAlignment = .center
    label.textColor = #colorLiteral(red: 0.004859850742, green: 0.1429360474, blue: 0.2692385255, alpha: 1)
    return label
  }()
  
  
  //MARK: ratingMovieLabel
  private let ratingLabel: UILabel = {
    let label = UILabel()
    label.text = "9.26"
    label.font = UIFont.systemFont(ofSize: 13, weight: .light)
    label.tintColor = .systemBlue
    return label
  }()
  
  //MARK: releaseMovieLabel
  private let releaseLabel: UILabel = {
    let label = UILabel()
    label.text = "9/10/2019"
    label.font = UIFont.systemFont(ofSize: 13, weight: .light)
    label.tintColor = .systemGray5
    return label
  }()
  
  //MARK: playButton
  lazy var playButton: UIButton = {
    let button = UIButton(type: .system)
//    let image = UIImage(systemName: "Play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 10))
    button.layer.cornerRadius = 18
    button.backgroundColor = #colorLiteral(red: 0.004859850742, green: 0.1429360474, blue: 0.2692385255, alpha: 1)
    button.setTitle("Play", for: .normal)
    button.tintColor = .white
//    button.setImage(image, for: .normal)
    button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
    button.isEnabled = true
    button.widthAnchor.constraint(equalToConstant: 150).isActive = true
    button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    return button
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let firstDetailStackView = UIStackView(arrangedSubviews: [
      starIconImage, ratingLabel, releaseLabel
    ])
    firstDetailStackView.spacing = 5//spacing between elements within the stackView
    firstDetailStackView.axis = .horizontal
    
    let secondStackView = UIStackView(arrangedSubviews: [
      titleLabel, firstDetailStackView, playButton
    ])
    secondStackView.spacing = 5
    secondStackView.axis = .vertical
    secondStackView.alignment = .center

    
    let globalStackView = UIStackView(arrangedSubviews: [
      imageMovie, secondStackView
    ])
    secondStackView.spacing = 20
    secondStackView.alignment = .center
   
    
    addSubview(globalStackView)
    
    globalStackView.fillSuperview(padding: .init(top: 15, left: 15, bottom: 15, right: 15))
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc
  func playButtonTapped() {
    print("play button was tapped")
  }
}
