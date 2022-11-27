//
//  Genre.swift
//  Desafio-Dimensa
//
//  Created by Vinicius on 26/11/22.
//

import Foundation

struct Genre: Decodable {
    let id: Int
    let name: String
}


struct GenresList: Decodable {
    let genres: [Genre]
}
