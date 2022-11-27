//
//  MovieView.swift
//  Desafio-Dimensa
//
//  Created by Vinicius on 26/11/22.
//

import UIKit

class MovieView: UIView {
    
    var expansibleView: ExpansibleView?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        tableView.register(HeaderCell.self, forHeaderFooterViewReuseIdentifier: HeaderCell.identifier)
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        expansibleView?.backgroundColor = .black
        setupView()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setHeader(header: UIView ) {

        tableView.tableHeaderView = header
        tableView.reloadData()
    }

    public func getHeader() -> UIView? {
        tableView.tableHeaderView
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
