//
//  Kid.swift
//  Trabalho SO
//
//  Created by Clinton de Sá Barreto Maciel on 14/12/16.
//  Copyright © 2016 clintonsbm. All rights reserved.
//

import UIKit

class Kid: NSObject {
    var haveBall: Bool
    
    var playTime: Int
    
    init(haveBall: Bool, playTime: Int) {
        
        self.haveBall = haveBall
        self.playTime = playTime
    }
}
