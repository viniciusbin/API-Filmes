//
//  MovieDetail.swift
//  Desafio-Dimensa
//
//  Created by Vinicius on 26/11/22.
//

import Foundation

struct MovieDetail: Decodable {
    let title: String?
    let popularity: Double?
    let vote_count: Int?
    let poster_path: String?
}
