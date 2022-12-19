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
    func presentError(error: Error)
}

class MovieDetailViewModel {
    
    var movieDetail: MovieDetail?
    var similarMovieDetail: SimilarMoviesList?
    var similarMovieIndex: SimilarMovie?
    var movieService = MovieService()
    var genreList: GenresList?
    public var delegate: MovieDetailsProtocol?
    
    
    
    func loadMovieDetailInfo(callback: @escaping() -> Void) {
        movieService.getMovieDetail { result in
            DispatchQueue.main.async {
                switch result {
                    
                case let .success(result):
                    self.movieDetail = result
                    callback()
                    self.loadSimilarMoviesInfo()
                  
                case let .failure(error):
                    self.delegate?.presentError(error: error)
                }
            }
        }
    }
    
    func loadSimilarMoviesInfo() {
        movieService.getSimilarMovieDetail { result in
            DispatchQueue.main.async {
                switch result {
                    
                case let .success(result):
                    self.similarMovieDetail = result
                    self.loadGenres()
                    
                case let .failure(error):
                    self.delegate?.presentError(error: error)
                }
            }
        }
    }
    
    func loadGenres() {
        movieService.getGenres { result in
            DispatchQueue.main.async {
                switch result {
                    
                case let .success(result):
                    GenreService.shared.genreList = result
                    self.delegate?.didGetData()
                    
                    
                case let .failure(error):
                    self.delegate?.presentError(error: error)
                }
            }
        }
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
    
    func showMovieDetail() throws -> MovieDetail? {
        guard let movieDetail = movieDetail else {
            throw MovieDetailViewModelError.runtimeError("Erro ao obter dados! Tente novamente.")
        }
        return movieDetail
    }
}
