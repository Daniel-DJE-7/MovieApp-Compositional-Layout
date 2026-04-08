//
//  PopularViewController.swift
//  MobileAppSwitfOnline
//
//  Created by Memo Figueredo on 23/3/26.
//

import UIKit

class PopularViewController: BaseListCollectionViewController {


  //MARK: - variables of instances
  var timer: Timer?
  var popularMovie: [Movie] = []
  let fetchPopularMovies = PopularAPICaller.shared

  // MARK: UI Elements
   fileprivate let searchController = UISearchController(searchResultsController: nil)
  
  
  // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
      
      collectionView.backgroundColor = .white     
      collectionView.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: PopularCollectionViewCell.identifier)
      
      setUpSearchBar()
      fetchPopular()
      
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.transform = .identity
  }
    
  //MARK: - Fetch Data
  func fetchPopular() {
    fetchPopularMovies.getPopularMovies { [weak self] popularResponse in
      switch popularResponse {
      case .success(let movie):
        self?.popularMovie = movie
        DispatchQueue.main.async {
          self?.collectionView.reloadData()
        }
      case .failure(let error):
        print("error: \(error.localizedDescription)")
      }
    }
  }
  
  func searchResults(query: String) {
    fetchPopularMovies.getSearchMovies(with: query) { [weak self] searchMovieResult in
        switch searchMovieResult {
        case .success(let movieResult):
          self?.popularMovie = movieResult
          DispatchQueue.main.async {
            self?.collectionView.reloadData()
          }
         case .failure(let error):
          print(error.localizedDescription)
      }
    }
  }
  
  
}

//MARK: - Extensions & delegates

extension PopularViewController: UICollectionViewDelegateFlowLayout {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return popularMovie.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath) as? PopularCollectionViewCell else {
      return  UICollectionViewCell()
    }
    cell.configure(with: popularMovie[indexPath.item])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
  }
  //aqui
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let defaultOffset = view.safeAreaInsets.top
    let offSet = scrollView.contentOffset.y + defaultOffset

    navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offSet))
  }
    
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let movie = popularMovie[indexPath.item]
    let vc = PopularDetailsViewController()
    vc.navigationItem.title = movie.title
    vc.movieDetails = movie
    self.navigationController?.pushViewController(vc, animated: true)
  }
    
  

}

extension PopularViewController: UISearchBarDelegate {
  func setUpSearchBar() {
    definesPresentationContext = true
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.delegate = self
  }
  //esto es el delegado
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    print(searchText)
    timer?.invalidate()
    
    timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
      self?.searchResults(query: searchText)
      DispatchQueue.main.async {
        self?.collectionView.reloadData()
      }
      
      if searchText.isEmpty {
        self?.fetchPopular()
      }
      
    })
  }
}





