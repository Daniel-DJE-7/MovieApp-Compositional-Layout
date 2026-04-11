//
//  PopularManager.swift
//  MobileAppSwitfOnline
//
//  Created by Memo Figueredo on 27/3/26.
//

import Foundation
import Alamofire

protocol PopularNetworkServiceProtocol {
  func fetchPopularMovies(completion: @escaping (Result<Movie, Error>) -> Void)
}


class PopularAPICaller {
  
  static let shared = PopularAPICaller()
  
  let baseURL = "https://api.themoviedb.org"
  let apiKey = "f06be6bcababc93f2529c7384395a3cc"
  let session = URLSession(configuration: .default)
  
  
  
  func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
    
    var components = URLComponents(string: baseURL + "/3/movie/popular")//Components evita la concatenación
        components?.queryItems = [
          URLQueryItem(name: "api_key", value: apiKey)
    ]
    
    guard let validationURL = components?.url else {
      print("invalid URL")
      return
    }
    
    AF.request(validationURL, method: .get)
      .validate(statusCode: 200..<300)
      .validate(contentType: ["application/json"])
      .responseDecodable(of: MoviesResponse.self) { response in
        switch response.result {
        case .success(let response):
          completion(.success(response.results))
        case .failure(let error):
          completion(.failure(error))
        }
      }
  }
  
  /*
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
  */
  
  func getSearchMovies(with query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
   let complementUrl = "/3/search/movie"
    
    
    guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
    
    var components = URLComponents(string: baseURL + complementUrl)
      components?.queryItems = [
        URLQueryItem(name: "query", value: query),//esto concatena la url
        URLQueryItem(name: "api_key", value: apiKey),
        URLQueryItem(name: "language", value: "en-Us")
      ]
    
    guard let validationUrl = components?.url else {
      print("invalid url")
      return
    }
    
    AF.request(validationUrl, method: .get)
      .validate(statusCode: 200..<300)
      .responseDecodable(of: MoviesResponse.self) { response in
        switch response.result {
        case .success(let response):
          completion(.success(response.results))
        case .failure(let error):
          completion(.failure(error))
        }
      }
  }
}
