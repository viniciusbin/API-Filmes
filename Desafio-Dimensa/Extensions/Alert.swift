//
//  Alert.swift
//  Desafio-Dimensa
//
//  Created by Vinicius on 03/12/22.
//

import Foundation
import UIKit

class Alert: NSObject {
    
    var controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func callAlert(title: String, message: String, completion: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel) { action in
            completion?()
        }
        alertController.addAction(okButton)
        controller.present(alertController, animated: true)
    }
}
