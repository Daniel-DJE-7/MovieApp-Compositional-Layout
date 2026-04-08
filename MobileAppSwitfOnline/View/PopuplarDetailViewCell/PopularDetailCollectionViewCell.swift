//
//  PopularDetailCollectionViewCell.swift
//  MobileAppSwitfOnline
//
//  Created by Memo Figueredo on 2/4/26.
//

import UIKit

class PopularDetailCollectionViewCell: UICollectionViewCell {
    
  static let identifier = "PopularDetailCollectionViewCell"
  
  // MARK: - IMAGE MOVIE
  private let movieImage: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.clipsToBounds = true
    image.layer.cornerRadius = 10
    image.widthAnchor.constraint(equalToConstant: 335).isActive = true
    image.heightAnchor.constraint(equalToConstant: 200).isActive = true
    return image
  }()
  
  // MARK: - Image Vote_average icon
  private let voteImage: UIImageView = {
    let image = UIImageView()
    image.tintColor = .systemGray
    image.image = UIImage(systemName: "person.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
    return image
  }()
  
  
  // MARK: - Popularity Label
  private let popularityLabel: UILabel = {
    let label = UILabel()
    label.tintColor = .systemGray4
    label.text = "0000"
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 13, weight: .light)
    return label
  }()
  
  // MARK: - Image language icon
  private let languageImage: UIImageView = {
    let image = UIImageView()
    image.tintColor = .systemGray
    image.image = UIImage(systemName: "speaker.wave.2", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
    return image
  }()
  
  // MARK: - Idiom Label
  private let idiomLabel: UILabel = {
    let label = UILabel()
    label.tintColor = .systemGray4
    label.text = "EN"
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 13, weight: .light)
    return label
  }()
  
  // MARK: - like language icon
  private let likeImage: UIImageView = {
    let image = UIImageView()
    image.tintColor = .systemGray
    image.image = UIImage(systemName: "hand.thumbsup", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
    return image
  }()
  
  
  // MARK: - Idiom Label
  private let likeLabel: UILabel = {
    let label = UILabel()
    label.tintColor = .systemGray4
    label.text = "0000"
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 13, weight: .light)
    return label
  }()
  
  // MARK: - Description Title label
  private let descriptionTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Description"
    label.tintColor = .black
    label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    label.textAlignment = .justified
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "ddadasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd"
    label.textColor = .systemGray
    label.font = UIFont.systemFont(ofSize: 15, weight: .light)
    label.numberOfLines = 15
    label.textAlignment = .left
    return label
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let firstStackView = UIStackView(arrangedSubviews: [
    voteImage, popularityLabel
    ])
    firstStackView.axis = .horizontal
    firstStackView.spacing = 5
   
    
    let secondStackView = UIStackView(arrangedSubviews: [
      languageImage, idiomLabel
    ])
    secondStackView.axis = .horizontal
    secondStackView.spacing = 5
   
    
    let thirdStackView = UIStackView(arrangedSubviews: [
      likeImage, likeLabel
    ])
    thirdStackView.axis = .horizontal
    thirdStackView.spacing = 5
  
    
    let detailsStackView = UIStackView(arrangedSubviews: [
    firstStackView, secondStackView, thirdStackView
    ])
    detailsStackView.axis = .horizontal
    detailsStackView.spacing = 10
    
    
    let overviewStackView = UIStackView(arrangedSubviews: [
      descriptionTitleLabel, descriptionLabel,
    ])
    overviewStackView.axis = .vertical
    overviewStackView.alignment = .center
    overviewStackView.spacing = 10
    //fiftStackView.distribution = .fillProportionally
    
    let globalStackView = UIStackView(arrangedSubviews: [
       movieImage, detailsStackView, overviewStackView
    ])
    globalStackView.axis = .vertical
    globalStackView.spacing = 10
    globalStackView.alignment = .center

    
    addSubview(globalStackView)
    
    globalStackView.fillSuperview(padding: .init(top: 15, left: 15, bottom: 15, right: 15))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  func configure(with model: Movie?) {
    let baseUrl = "https://image.tmdb.org/t/p/w500"
    let posterPath = model?.backdropPath ?? ""
    
    guard let model = model,
      let url = URL(string: baseUrl + posterPath) else { return }
    //return the image
    movieImage.kf.indicatorType = .activity
    movieImage.kf.setImage(with: url, options: [
      .scaleFactor(UIScreen.main.scale),
      .transition(.fade(0.3)),
      .cacheOriginalImage
    ])
    
    popularityLabel.text = String(format: "%.2f", model.popularity)
    idiomLabel.text = model.originalLanguage
    likeLabel.text = String(format: "%.1f", model.voteAverage)
    descriptionLabel.text = model.overview
  }
  
}
