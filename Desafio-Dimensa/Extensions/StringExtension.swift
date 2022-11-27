//
//  StringExtension.swift
//  Desafio-Dimensa
//
//  Created by Vinicius on 27/11/22.
//

import Foundation

extension String {
    func getInitialCharacters(_ howManyCharacters: Int) -> String {
        
        if self.count < howManyCharacters {
            NSLog("string invalid", self)
            return self
        }
        
        var aux = ""
        for char in self{
            aux.append(char)
            if aux.count == howManyCharacters {
                return aux
            }
        }
        
        return self
    }
}
