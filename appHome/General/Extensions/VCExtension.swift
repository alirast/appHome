//
//  VCExtension.swift
//  appHome
//
//  Created by N S on 19.07.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func popBackViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func popToRootViewController() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
   @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
