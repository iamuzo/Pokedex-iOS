//
//  UIViewControllerExtension.swift
//  Pokedex
//
//  Created by Uzo on 1/21/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentErrorToUser(localizedError: LocalizedError) {
        let alertController = UIAlertController(title: "ERROR", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel
            , handler: nil)
        
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
}
