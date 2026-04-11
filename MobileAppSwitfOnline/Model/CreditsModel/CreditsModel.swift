//
//  CreditsModel.swift
//  MobileAppSwitfOnline
//
//  Created by Memo Figueredo on 3/4/26.
//

import Foundation


struct MovieCreditsResponse: Codable {
    let id: Int
    let cast: [Cast]
    let crew: [Crew]
}

struct Cast: Codable {
    let id: Int
    let name: String
    let character: String?
    let profilePath: String?
    let order: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case character
        case profilePath = "profile_path"
        case order
    }
}

struct Crew: Codable {
    let id: Int
    let name: String
    let job: String?
    let department: String?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case job
        case department
        case profilePath = "profile_path"
    }
}
