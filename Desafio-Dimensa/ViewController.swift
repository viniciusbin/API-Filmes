//
//  ViewController.swift
//  Desafio-Dimensa
//
//  Created by Vinicius on 25/11/22.
//

import UIKit

class ViewController: UIViewController {
    var homeView: MovieView?
    var movieService = MovieService()
    var movieDetail: MovieDetail?
    var similarMovieDetail: SimilarMoviesList?
    
    override func loadView() {
        self.homeView = MovieView()
        self.view = homeView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let header = ExpansibleView(frame: CGRect(x: 0, y: 0,
                                                           width: view.frame.size.width,
                                                           height: view.frame.size.width))
        header.backgroundColor = .black
        
        header.imageView.downloaded(from: "https://image.tmdb.org/t/p/original\(movieDetail?.poster_path ?? "")")
        homeView?.setHeader(header: header)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        homeView?.tableView.delegate = self
        homeView?.tableView.dataSource = self
        navigationController?.navigationBar.isHidden = true
        
        
        movieService.getMovieDetail { result in
            DispatchQueue.main.async {
                switch result {
                    
                case let .success(result):
                    self.movieDetail = result
                    self.homeView?.tableView.reloadData()
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
                    self.homeView?.tableView.reloadData()
                    print(self.similarMovieDetail?.movies[0])
                    
                case let .failure(error):
                    print(error)
                }
            }
        }
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderCell.identifier) as! HeaderCell
        guard let movie = movieDetail else {return UITableViewCell()}
        header.configure(movieDetail: movie)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return similarMovieDetail?.movies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        guard let movieIndex = similarMovieDetail?.movies[indexPath.row] else {return UITableViewCell()}
        cell.configure(similarMovie: movieIndex)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

//MARK: - ScrollView Delegate
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = homeView?.getHeader() as? ExpansibleView else {
            return
        }
        header.scrollViewDidScroll(scrollView: homeView?.tableView ?? UIScrollView())
    }
}

