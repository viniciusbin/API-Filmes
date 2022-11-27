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
    var movieService = MovieService()
    
    public var delegate: MovieDetailsProtocol?
    
    
   
    
    func loadMovieInfo() {
        movieService.getMovieDetail { result in
            DispatchQueue.main.async {
                switch result {
                    
                case let .success(result):
                    self.movieDetail = result
                    self.delegate?.didGetData()
                case let .failure(error):
                    print(error)
                }
            }
            
        }
        
        movieService.getSimilarMovieDetail { result in
            DispatchQueue.main.async {
                switch result {
                    
                case let .success(result):
                    self.similarMovieDetail = result
                    self.delegate?.didGetData()
                    print(self.similarMovieDetail?.movies[0])
                    
                case let .failure(error):
                    print(error)
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
    
    func movieDetailTransporter() -> MovieDetail? {
        
        return movieDetail
    }
}
