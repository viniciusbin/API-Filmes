//
//  GenreService.swift
//  Desafio-Dimensa
//
//  Created by Vinicius on 28/11/22.
//

import Foundation

class GenreService {
    
    
    static let shared = GenreService()
    private init() {}
    public var genreList: GenresList?
}

