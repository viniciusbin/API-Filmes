//
//  MovieService.swift
//  Desafio-Dimensa
//
//  Created by Vinicius on 26/11/22.
//

import Foundation
enum ServiceError: Error {
    case invalidURL
    case decodeFail(Error?)
    case network(Error?)
    case noData
}

class MovieService {
    
    private let apiKey = "20efa529960e79f1faeab7b31a072b75"
    private let movieId = 120
    private var movieUrl: URL?
    private var similarMoviesURL: URL?
    
    init() {
        movieUrl = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(apiKey)&language=en-US")
        similarMoviesURL = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/similar?api_key=\(apiKey)&language=en-US&page=1")
    }
    
    
    func getMovieDetail(callback: @escaping(Result<MovieDetail, Error>) -> Void) {
    
        guard let url = movieUrl else {
            callback(.failure(ServiceError.invalidURL))
            return
        }
           let task = URLSession.shared.dataTask(with: url) { data, response, error in
               guard let data = data else {
                   callback(.failure(ServiceError.network(error)))
                   return
               }
                        do {
                            let movieDetail = try? JSONDecoder().decode(MovieDetail.self, from: data)
                            guard let movieDetailSucess = movieDetail else {
                                callback(.failure(ServiceError.noData))
                                return
                            }
                            
                            callback(.success(movieDetailSucess))
                            
                        } catch {
                            callback(.failure(ServiceError.decodeFail(error)))
                        }
                    }
                    task.resume()
                }
    
    func getSimilarMovieDetail(callback: @escaping(Result<SimilarMoviesList, Error>) -> Void) {
    
        guard let url = similarMoviesURL else {
            callback(.failure(ServiceError.invalidURL))
            return
        }
           let task = URLSession.shared.dataTask(with: url) { data, response, error in
               guard let data = data else {
                   callback(.failure(ServiceError.network(error)))
                   return
               }
                        do {
                            let similarMovieDetail = try? JSONDecoder().decode(SimilarMoviesList.self, from: data)
                            guard let similarMovieDetailSucess = similarMovieDetail else {
                                callback(.failure(ServiceError.noData))
                                return
                            }
                            
                            callback(.success(similarMovieDetailSucess))
//                            print(similarMovieDetailSucess)
                        } catch {
                            callback(.failure(ServiceError.decodeFail(error)))
                        }
                    }
                    task.resume()
                }
    
    }
