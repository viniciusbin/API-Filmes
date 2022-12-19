//
//  MovieView.swift
//  Desafio-Dimensa
//
//  Created by Vinicius on 26/11/22.
//

import UIKit

protocol MovieViewProtocol: AnyObject {
    func updateData()
}

class MovieView: UIView {
    
    var expansibleView: ExpansibleView?
    public var delegate: MovieViewProtocol?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        tableView.register(HeaderCell.self, forHeaderFooterViewReuseIdentifier: HeaderCell.identifier)
        tableView.backgroundColor = .black
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func setHeader(header: UIView ) {
        
            self.tableView.tableHeaderView = header
        delegate?.updateData()
        
    }
    
    public func getHeader() -> UIView? {
        return tableView.tableHeaderView
        
    }
}

extension MovieView: ViewCodable {
    func buildHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
