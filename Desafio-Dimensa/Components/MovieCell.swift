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
    
    lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "Filme Similar"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var labelYear: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "1991"
        return label
    }()
    
    lazy var labelGenre: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Ação"
        return label
    }()
    
    lazy var divisorLine: UIImageView = {
        let line = UIImageView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(red: 219.0/255.0, green: 219.0/255.0, blue: 219.0/255.0, alpha: 1.0)
        return line
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        contentView.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(similarMovie: SimilarMovie, genre: String) {
        labelTitle.text = similarMovie.title
        labelYear.text = String(similarMovie.date.prefix(4))
        labelGenre.text = genre
        movieImage.downloaded(from: ("https://image.tmdb.org/t/p/original\(similarMovie.posterPath ?? "")"))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImage.image = UIImage()
        
    }
}

extension MovieCell: ViewCodable {
    
    func buildHierarchy() {
        contentView.addSubview(movieImage)
        contentView.addSubview(labelTitle)
        contentView.addSubview(labelYear)
        contentView.addSubview(labelGenre)
        contentView.addSubview(divisorLine)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            movieImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -10),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            movieImage.widthAnchor.constraint(equalToConstant: 80),
            
            labelTitle.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 12),
            labelTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -13),
            
            labelYear.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 12),
            labelYear.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 13),
            
            labelGenre.leadingAnchor.constraint(equalTo: labelYear.trailingAnchor, constant: 8),
            labelGenre.centerYAnchor.constraint(equalTo: labelYear.centerYAnchor),
            
            divisorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            divisorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            divisorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 90),
            divisorLine.heightAnchor.constraint(equalToConstant:  0.2)
        ])
    }
}
