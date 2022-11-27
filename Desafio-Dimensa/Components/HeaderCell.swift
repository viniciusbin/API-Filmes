//
//  HeaderCell.swift
//  Desafio-Dimensa
//
//  Created by Vinicius on 25/11/22.
//

import UIKit

class HeaderCell: UITableViewHeaderFooterView {
    
    static let identifier = "HeaderCell"
        
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Teste "
        
        return label
    }()
    
    lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "1.2K Likes"
        
        return label
    }()
    
    lazy var likesIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "heart.fill")
        icon.tintColor = .white
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
        
    }()
    
    lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "12K Views"
        return label
    }()
    
    lazy var viewsIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "play.tv.fill")
        icon.tintColor = .white
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(movieDetail: MovieDetail?) {
        titleLabel.text = movieDetail?.title
        likesLabel.text = "\(movieDetail?.vote_count?.divideBy1000() ?? 0)K Likes"
        viewsLabel.text = "\(((movieDetail?.popularity ?? 0) * 10 ).rounded() / 10)K Views"
    }
    
    
    @objc
    private func likeButtonPressed() {
        likeButton.isSelected = !likeButton.isSelected
        updateButtonState()
    }
    
    private func setupLikeButton() {
        likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        likeButton.isSelected = false
    }
    
    private func updateButtonState() {
        let heartConfig = UIImage.SymbolConfiguration(
            font: UIFont.preferredFont(forTextStyle: .title1)
        )
        if likeButton.isSelected {
            if let image = UIImage(systemName: "heart.fill", withConfiguration: heartConfig) {
                likeButton.setImage(image, for: .normal)
            }
            
        } else {
            if let image = UIImage(systemName: "heart", withConfiguration: heartConfig) {
                likeButton.setImage(image, for: .normal)
            }
        }
    }
    
    
}
extension HeaderCell: ViewCodable {
    func buildHierarchy() {
        contentView.addSubview(likeButton)
        setupLikeButton()
        contentView.addSubview(titleLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(likesIcon)
        contentView.addSubview(viewsLabel)
        contentView.addSubview(viewsIcon)
        updateButtonState()
    }
    
    func setupConstraints() {
         NSLayoutConstraint.activate([
             titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
             titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
             titleLabel.heightAnchor.constraint(equalToConstant: 45),
             titleLabel.widthAnchor.constraint(equalToConstant: 300),
         
             likeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
             likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
             likeButton.heightAnchor.constraint(equalToConstant: 20),
             likeButton.widthAnchor.constraint(equalToConstant: 25),
         
             likesLabel.leadingAnchor.constraint(equalTo: likesIcon.trailingAnchor, constant: 5),
             likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -10),
             likesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
             likesLabel.heightAnchor.constraint(equalToConstant: 35),
        
             likesIcon.centerYAnchor.constraint(equalTo: likesLabel.centerYAnchor),
             likesIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
   
             viewsLabel.centerYAnchor.constraint(equalTo: likesLabel.centerYAnchor),
             viewsLabel.leadingAnchor.constraint(equalTo: viewsIcon.trailingAnchor,constant: 5),
             viewsLabel.heightAnchor.constraint(equalToConstant: 35),
      
             viewsIcon.centerYAnchor.constraint(equalTo: likesLabel.centerYAnchor),
             viewsIcon.leadingAnchor.constraint(equalTo: likesLabel.trailingAnchor, constant: 10)
         ])
    }
    
    
}

