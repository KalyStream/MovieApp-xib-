//
//  MovieResponse.swift
//  Kino_kz_Clone
//
//  Created by Kalybay Zhalgasbay on 19.04.2022.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [MovieInfo]
}

struct MovieInfo: Decodable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalTitle, overview: String
    let posterPath: String?
    let releaseDate: String
    let voteAverage: Double?
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

