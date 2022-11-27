//
//  MovieCell.swift
//  Desafio-Dimensa
//
//  Created by Vinicius on 26/11/22.
//

import UIKit

    class MovieCell: UITableViewCell {
        
        static let identifier = "MovieCell"
  
        lazy var movieImage: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints  = false
            image.image = UIImage(systemName: "sofa.fill")
            return image
        }()
        lazy var title: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .white
            label.font = .systemFont(ofSize: 20, weight: .medium)
            label.text = "Filme Similar"
            return label
        }()
        lazy var year: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .white
            label.font = .systemFont(ofSize: 16, weight: .regular)
            label.text = "1991"
            return label
        }()
        lazy var genre: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .white
            label.font = .systemFont(ofSize: 16, weight: .regular)
            label.text = "Ação"
            return label
        }()
    
 
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupView()
            contentView.backgroundColor = .black
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
  
        func configure(similarMovie: SimilarMovie) {
            title.numberOfLines = 0
            title.text = similarMovie.title
            year.text = similarMovie.date.getInitialCharacters(4)
//            genre.text = similarMovie.String(genres)
            movieImage.downloaded(from: ("https://image.tmdb.org/t/p/original\(similarMovie.posterPath ?? "")"))

        }
    }
extension MovieCell: ViewCodable {
    func buildHierarchy() {
        contentView.addSubview(movieImage)
        contentView.addSubview(title)
        contentView.addSubview(year)
        contentView.addSubview(genre)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            movieImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -10),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            movieImage.widthAnchor.constraint(equalToConstant: 80),
            
            
            title.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 12),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -13),
            
            year.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 12),
            year.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 13),
            
            genre.leadingAnchor.constraint(equalTo: year.trailingAnchor, constant: 8),
            genre.centerYAnchor.constraint(equalTo: year.centerYAnchor),
         
        ])
    }
    
    
}

