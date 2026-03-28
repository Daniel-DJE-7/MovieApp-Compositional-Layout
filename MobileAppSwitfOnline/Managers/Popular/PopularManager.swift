//
//  PopularManager.swift
//  MobileAppSwitfOnline
//
//  Created by Memo Figueredo on 27/3/26.
//

import Foundation

class PopularAPICaller {
  
  static let shared = PopularAPICaller()
  
  static let apiKey = "f06be6bcababc93f2529c7384395a3cc"
  let session = URLSession(configuration: .default)
  
  func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
    guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(PopularAPICaller.apiKey)") else { return }
     let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
       guard let data = data, error == nil else { return }
       do {
         let result = try JSONDecoder().decode(MoviesResponse.self, from: data)
         completion(.success(result.results))
       } catch {
         completion(.failure(error))
       }
    })
    task.resume()
  }
  
}
