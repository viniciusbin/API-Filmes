//
//  IntExtension.swift
//  Desafio-Dimensa
//
//  Created by Vinicius on 27/11/22.
//

import Foundation

extension Int {
    
    func divideBy1000() -> IntegerLiteralType{
        (Int(self) / 100) / 10
    }
}
