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
    
    init(size: Int) {
        self.size = size
    }
}
