//
//  MovieDetailViewModel.swift
//  Desafio-Dimensa
//
//  Created by Vinicius on 27/11/22.
//

import Foundation

enum MovieDetailViewModelError: Error {
    case runtimeError(String)
}

protocol MovieDetailsProtocol: AnyObject {
    func didGetData()
}

class MovieDetailViewModel {
    
    var movieDetail: MovieDetail?
    var similarMovieDetail: SimilarMoviesList?
    var similarMovieIndex: SimilarMovie?
    var movieService = MovieService()
    var genreList: GenresList?
    
    
    public var delegate: MovieDetailsProtocol?
    
    func loadMovieDetailInfo() {
        movieService.getMovieDetail { result in
            DispatchQueue.main.async {
                switch result {
                    
                case let .success(result):
                    self.movieDetail = result
                    
                    self.delegate?.didGetData()
                    loadSimilarMoviesInfo()
                case let .failure(error):
                    print(error)
                }
            }
            
        }
        func loadSimilarMoviesInfo() {
            movieService.getSimilarMovieDetail { result in
                DispatchQueue.main.async {
                    switch result {
                        
                    case let .success(result):
                        self.similarMovieDetail = result
                        print(self.similarMovieDetail?.movies[0].genres)
                        self.delegate?.didGetData()
                        self.loadGenres()
                        
                    case let .failure(error):
                        print(error)
                    }
                }
            }
            
        }
    }
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfRows() -> Int {
        return  similarMovieDetail?.movies.count ?? 0
    }
    
    public func similarMovieIndex(_ index: Int) throws -> SimilarMovie {
        guard let similarMovie = similarMovieDetail else {
            throw MovieDetailViewModelError.runtimeError("Erro ao obter dados! Tente novamente.")
        }
        return similarMovie.movies[index]
    }
    
    func showMovieDetail() -> MovieDetail? {
        
        return movieDetail
    }
    
    func loadGenres() {
        movieService.getGenres { result in
            DispatchQueue.main.async {
                switch result {
                    
                case let .success(result):
                    GenreService.shared.genreList = result
                    
                    
                    print("dentro da req na view model")
                    print(GenreService.shared.genreList?.genres[0].id)
                    self.delegate?.didGetData()
                    
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
//    func getFormattedGenres(ids: [Int]) -> String {
//        if genreList.isEmpty {
//            loadGenres()
//        }
//        var formatedGenres = [String]()
//            ids.forEach { id in
//                formatedGenres.append(genreList[id] ?? "")
//            }
//        print(formatedGenres)
//        //Adiciona vírgulas entre os gêneros
//        return formatedGenres.joined(separator: ", ")
//    }
    
    
    
}
