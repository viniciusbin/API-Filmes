//
//  GradientView.swift
//  Desafio-Dimensa
//
//  Created by Vinicius on 26/11/22.
//

import Foundation
import UIKit

final class GradientView: UIView {
    override public class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        let gradientLayer = self.layer as! CAGradientLayer
        gradientLayer.colors = [
            UIColor.init(white: 0.2, alpha: 0).cgColor,
            UIColor.black.cgColor
            
        ]
        backgroundColor = UIColor.clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
