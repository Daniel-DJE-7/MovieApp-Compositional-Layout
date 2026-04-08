//
//  Actors.swift
//  MobileAppSwitfOnline
//
//  Created by Memo Figueredo on 3/4/26.
//

import Foundation
import Alamofire

class ActorsAPICaller {
  
  static let shared = ActorsAPICaller()
  let baseURL = "https://api.themoviedb.org/3/movie/{movie_id}/credits"
  let apiKey = "f06be6bcababc93f2529c7384395a3cc"
  
  //apicaller para credits
  //gatillas por el id en el popular viewController
  //el llamado de la API se hace en details
  
  func getPopularCreditsOfActors(movieId: Int, completion: @escaping (Result<MovieCreditsResponse, Error>) -> Void) {
    var components = URLComponents(string: baseURL.replacingOccurrences(of: "{movie_id}", with: String(movieId)))
    components?.queryItems = [
      URLQueryItem(name: "api_key", value: apiKey)
    ]
    
    guard let validationURL = components?.url else {
      print("invalid URL")
      return
    }
    
    AF.request(validationURL, method: .get)
      .validate(statusCode: 200..<300)
      .responseDecodable(of: MovieCreditsResponse.self) { response in
        switch response.result {
        case .success(let response):
          completion(.success(response))
        case .failure(let error):
          completion(.failure(error))
        }
      }
  }
}
