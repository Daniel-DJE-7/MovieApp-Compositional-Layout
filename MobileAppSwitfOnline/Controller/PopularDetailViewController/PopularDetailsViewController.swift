//
//  PopularDetailsViewController.swift
//  MobileAppSwitfOnline
//
//  Created by Memo Figueredo on 2/4/26.
//

import UIKit

enum SectionType: Int, CaseIterable {
  case detailsMovie = 0// 1
  case actors = 1//2
}

class PopularDetailsViewController: BaseListCollectionViewController {
  
  private let spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView()
    spinner.tintColor = .label
    spinner.hidesWhenStopped = true
    return spinner
  }()
  
  var movieDetails: Movie?
  var cast: [Cast] = []
  private var sections: [SectionType] = []
  private var actors: [Cast] = []
  private let titlesSection: String = "Actors"
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemPink
    navigationItem.largeTitleDisplayMode = .never
    let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection in
      return self.createSectionLayout(section: sectionIndex)
    }
    collectionView.setCollectionViewLayout(layout, animated: false)
    view.addSubview(spinner)

    registerCells()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.transform = .identity
    
    fetchData()
  }
  
  //MARK: - Creating the compositional layout
  func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
   //Header View
    let header = [
    NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1),
        heightDimension: .absolute(50)
      ),
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top
    )
   ]
    
    //Sections
    switch section {
    case 0:
        //MARK: - first Vertical section
        //item
        let firstItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(450)
          )
        )
        //group
        let firstGroup = NSCollectionLayoutGroup.vertical(
          layoutSize: firstItem.layoutSize,
          subitem: firstItem,
          count: 1
        )
     // firstGroup.contentInsets = .init(top: 0, leading: 5, bottom: 5, trailing: 5)
        //section
        let section = NSCollectionLayoutSection(group: firstGroup)
        return section
      
      //MARK: - Second Vertical section
      case 1:
        //item
        let secondtItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
          )
        )
      secondtItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 6)
        //group
        let secondGroup = NSCollectionLayoutGroup.horizontal(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.9),
            heightDimension: .absolute(200)
          ),
          subitem: secondtItem,
          count: 5
        )
      
      secondGroup.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        //section
        let secondSection = NSCollectionLayoutSection(group: secondGroup)
            secondSection.orthogonalScrollingBehavior = .continuous
            secondSection.interGroupSpacing = 10
            //I place this here to see the header in the second section
            secondSection.boundarySupplementaryItems = header
        return secondSection
      
    default:
        //MARK: - defaultSection Vertical section
        //item
        let defautltItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .estimated(140),
            heightDimension: .absolute(200)
          )
        )
        //group
        let defaultGroup = NSCollectionLayoutGroup.vertical(
          layoutSize: defautltItem.layoutSize,
          subitem: defautltItem,
          count: 1
        )
        //section
        let defaultSection = NSCollectionLayoutSection(group: defaultGroup)
      defaultSection.boundarySupplementaryItems = header
        return defaultSection

    }
  }

  
  //MARK: - registering cells
  private func registerCells() {
    collectionView.register(PopularDetailCollectionViewCell.self, forCellWithReuseIdentifier: PopularDetailCollectionViewCell.identifier)
    collectionView.register(PopularActorsCollectionViewCell.self, forCellWithReuseIdentifier: PopularActorsCollectionViewCell.identifier)
    collectionView.register(TitleHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier)
  }
  
  
  //MARK: - fetching data
  func fetchData() {
    guard let movieId = movieDetails?.id else { return }
    ActorsAPICaller.shared.getPopularCreditsOfActors(movieId: movieId) { [weak self] result in
      switch result {
      case .success(let movie):
        self?.actors = movie.cast
        DispatchQueue.main.async {
          self?.collectionView.reloadData()
        }
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  
}

// MARK: - Delegates
extension PopularDetailsViewController: UICollectionViewDelegateFlowLayout {
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return SectionType.allCases.count
  }
  //numero de secciones en la collectionView
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //return 1
    guard let section = SectionType(rawValue: section) else { return 0 }
    
    switch section {
    case .detailsMovie:
        return 1
    case .actors:
      return actors.count
    }
  }
  
  //celdas
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let section = SectionType(rawValue: indexPath.section) else {
      return UICollectionViewCell()
    }
    
    switch section {
    case .detailsMovie:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularDetailCollectionViewCell.identifier, for: indexPath) as? PopularDetailCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.configure(with: movieDetails)
      return cell
      
    case .actors:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularActorsCollectionViewCell.identifier, for: indexPath) as? PopularActorsCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.configure(with: actors[indexPath.item])
      return cell
    }
  }
  
  //MARK: - HeaderView
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
   
    guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleHeaderCollectionReusableView.identifier, for: indexPath) as? TitleHeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else {
      return UICollectionReusableView()
    }
    header.configure(with: titlesSection)
    return header
  }
  
}
