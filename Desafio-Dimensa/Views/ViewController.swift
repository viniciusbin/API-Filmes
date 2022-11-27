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
    var viewModel = MovieDetailViewModel()
    
    override func loadView() {
        self.homeView = MovieView()
        self.view = homeView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let header = ExpansibleView(frame: CGRect(x: 0, y: 0,
                                                           width: view.frame.size.width,
                                                           height: view.frame.size.width))
        header.backgroundColor = .black
        
        header.imageView.downloaded(from: "https://image.tmdb.org/t/p/original\(viewModel.movieDetail?.poster_path ?? "")")
        homeView?.setHeader(header: header)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        homeView?.tableView.delegate = self
        homeView?.tableView.dataSource = self
        navigationController?.navigationBar.isHidden = true
        viewModel.delegate = self
        viewModel.loadMovieInfo()
        
        

        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderCell.identifier) as! HeaderCell
        let movie = viewModel.movieDetailTransporter()
        header.configure(movieDetail: movie)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        
        do {
            let movieDetail = try viewModel.similarMovieIndex(indexPath.row)
            cell.configure(similarMovie: movieDetail)
        } catch {
//            alert(title: "Opa!", message: error.localizedDescription)
        }
        
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

extension ViewController: MovieDetailsProtocol {
    func didGetData() {
        homeView?.tableView.reloadData()
    }
    
 
    
    
    
}
