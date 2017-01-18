//
//  Basket.swift
//  Trabalho SO
//
//  Created by Clinton de Sá Barreto Maciel on 14/12/16.
//  Copyright © 2016 clintonsbm. All rights reserved.
//

import UIKit

class Basket: NSObject {
    var size: Int
    var currentBalls: Int = 0
    var label: UILabel
    
    init(size: Int, label: UILabel) {
        self.size = size
        self.label = label
    }
    
    func placeBall() {
        self.currentBalls += 1
        
        DispatchQueue.main.async {
           self.label.text = "\(self.currentBalls)/\(self.size)"
        }
    }
    
    func takeBall() {
        self.currentBalls -= 1
        
        DispatchQueue.main.async {
            self.label.text = "\(self.currentBalls)/\(self.size)"
        }
    }
}
