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
    
    
    func getUser(callback: @escaping(Result<MovieDetail, Error>) -> Void) {
    
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
                            print(movieDetailSucess)
                        } catch {
                            callback(.failure(ServiceError.decodeFail(error)))
                        }
                    }
                    task.resume()
                }
    
//    func getRepo(gitUser: String, callback: @escaping(Result<[Repo], Error>) -> Void) {
//
//        guard let url = URL(string: baseURL + gitUser + "/repos") else {
//            callback(.failure(ServiceError.invalidURL))
//            return
//        }
//           let task = URLSession.shared.dataTask(with: url) { data, response, error in
//               guard let data = data else {
//                   callback(.failure(ServiceError.network(error)))
//                   return
//               }
//                        do {
//                            let repo = try? JSONDecoder().decode([Repo].self, from: data)
//                            guard let repo = repo else {
//                                callback(.failure(ServiceError.noData))
//                                return
//                            }
//
//                            callback(.success(repo))
//                            //print(repo)
//                        } catch {
//                            callback(.failure(ServiceError.decodeFail(error)))
//                        }
//                    }
//                    task.resume()
//                }
    }
