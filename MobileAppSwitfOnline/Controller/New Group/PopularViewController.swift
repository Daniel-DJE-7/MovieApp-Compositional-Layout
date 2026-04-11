//
//  PopularViewController.swift
//  MobileAppSwitfOnline
//
//  Created by Memo Figueredo on 23/3/26.
//

import UIKit

final class PopularViewController: BaseListCollectionViewController {

  let fetchPopularMovies = PopularAPICaller.shared

    override func viewDidLoad() {
        super.viewDidLoad()
      
      collectionView.backgroundColor = .white
      collectionView.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: PopularCollectionViewCell.identifier)
      
      fetchPopular()
    }
    
  func fetchPopular() {
    fetchPopularMovies.getPopularMovies { [weak self] popularResponse in
      switch popularResponse {
      case .success(let movie):
        print(movie[0].title)
      case .failure(let error):
        print("error: \(error.localizedDescription)")
      }
    }
  }


}

extension PopularViewController: UICollectionViewDelegateFlowLayout {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath) as? PopularCollectionViewCell ?? UICollectionViewCell()
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
  }
}
