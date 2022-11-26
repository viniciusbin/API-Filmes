//
//  ViewCodableProtocol.swift
//  Desafio-Dimensa
//
//  Created by Vinicius on 25/11/22.
//

import UIKit

public protocol ViewCodable {
    func buildHierarchy()
    func setupConstraints()
    func applyAdditionalChanges()
}

public extension ViewCodable {
    func setupView() {
        buildHierarchy()
        setupConstraints()
        applyAdditionalChanges()
    }
    
    func applyAdditionalChanges() {}
}
