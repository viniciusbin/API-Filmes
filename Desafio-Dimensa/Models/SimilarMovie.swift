//
//  SimilarMovie.swift
//  Desafio-Dimensa
//
//  Created by Vinicius on 26/11/22.
//

import Foundation


struct SimilarMoviesList: Decodable {
    let movies: [SimilarMovie]
}

struct SimilarMovie: Decodable {
    let title: String
    let posterPath: String?
    let genres: [Int]
    let date: String
    
}


extension SimilarMovie {
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case posterPath = "poster_path"
        case genres = "genre_ids"
        case date = "release_date"
        
    }
}

extension SimilarMoviesList {
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
