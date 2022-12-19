//
//  MovieViewController.swift
//  Desafio-Dimensa
//
//  Created by Vinicius on 25/11/22.
//

import UIKit

class MovieViewController: UIViewController {
    var homeView: MovieView?
    var movieService = MovieService()
    var viewModel = MovieDetailViewModel()
    var genreList: [Int: String] = [:]
    var alert: Alert?
    
    override func loadView() {
        self.homeView = MovieView()
        self.view = homeView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        homeView?.delegate = self
        view.backgroundColor = .black
        homeView?.tableView.delegate = self
        homeView?.tableView.dataSource = self
        navigationController?.navigationBar.isHidden = true
        
        viewModel.loadMovieDetailInfo {
            let header = ExpansibleView(frame: CGRect(x: 0, y: 0,
                                                      width: self.view.frame.size.width,
                                                      height: self.view.frame.size.height / 2))
            do {
                let movieDetail = try self.viewModel.showMovieDetail()
                header.imageView.downloaded(from: "https://image.tmdb.org/t/p/original\(movieDetail?.poster_path ??  "sofa.fill")")
                
                self.homeView?.setHeader(header: header)
            } catch {
                print(error)
            }
        }
        alert = Alert(controller: self)
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderCell.identifier) as! HeaderCell
        do {
            let movie = try viewModel.showMovieDetail()
            header.configure(movieDetail: movie)
        } catch {
            print((error))
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        
        do {
            let movieDetail = try viewModel.similarMovieIndex(indexPath.row)
            
            GenreService.shared.genreList?.genres.forEach { genre in
                self.genreList[genre.id] = genre.name
                
            }
            var stringGenres = [String]()
            movieDetail.genres.forEach { id in
                stringGenres.append(genreList[id] ?? "")
            }
            let genreIndex = stringGenres.joined(separator: ", ")
            cell.configure(similarMovie: movieDetail, genre: genreIndex)
            
        } catch {
            print(error.localizedDescription)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

extension MovieViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard let header = self.homeView?.getHeader() as? ExpansibleView else {
            return
        }
        header.scrollViewDidScroll(scrollView: self.homeView?.tableView ?? UIScrollView())
        
    }
}

extension MovieViewController: MovieDetailsProtocol {
    
    func presentError(error: Error) {
        alert?.callAlert(title: "Atenção", message: "Erro na requisição, tente novamente!", completion: nil)
    }
    
    
    func didGetData() {
        homeView?.tableView.reloadData()
        
    }
}

extension MovieViewController: MovieViewProtocol {
    func updateData() {
        homeView?.tableView.reloadData()
    }
    
    
}

