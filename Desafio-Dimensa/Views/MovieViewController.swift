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
        DispatchQueue.main.async {
            let header = ExpansibleView(frame: CGRect(x: 0, y: 0,
                                                      width: self.view.frame.size.width,
                                                      height: self.view.frame.size.height / 2))
            header.imageView.downloaded(from: "https://image.tmdb.org/t/p/original\(self.viewModel.movieDetail?.poster_path ?? "")")
            self.homeView?.setHeader(header: header)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        homeView?.tableView.delegate = self
        homeView?.tableView.dataSource = self
        navigationController?.navigationBar.isHidden = true
        viewModel.delegate = self
        viewModel.loadMovieDetailInfo()
        alert = Alert(controller: self)
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderCell.identifier) as! HeaderCell
        let movie = viewModel.showMovieDetail()
        header.configure(movieDetail: movie)
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
            print("configure na controller")
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
        guard let header = homeView?.getHeader() as? ExpansibleView else {
            return
        }
        header.scrollViewDidScroll(scrollView: homeView?.tableView ?? UIScrollView())
    }
}

extension MovieViewController: MovieDetailsProtocol {
    
    func presentError(error: Error) {
        alert?.callAlert(title: "Atenção", message: "Erro na requisição, tente novamente!", completion: nil)
    }
    
    
    func didGetData() {
        homeView?.tableView.reloadData()
        print("reload data chamado")
    }
}
