//
//  Kid.swift
//  Trabalho SO
//
//  Created by Clinton de Sá Barreto Maciel on 14/12/16.
//  Copyright © 2016 clintonsbm. All rights reserved.
//

import UIKit

class Kid: NSObject {
    let id: Int
    
    var haveBall: Bool
    
    let playTime: Int
    
    var isPlaying: Bool?
    
    let basket: Basket?
    
    //Semaphores
    var mutex: DispatchSemaphore
    var empty: DispatchSemaphore
    var full: DispatchSemaphore
    
    init(id: Int, haveBall: Bool, playTime: Int, semaphores: [DispatchSemaphore], basket: Basket) {
        self.id = id
        self.haveBall = haveBall
        self.playTime = playTime
        
        self.mutex = semaphores[0]
        self.empty = semaphores[1]
        self.full = semaphores[2]
        
        self.basket = basket
    }
    
    func startKit() {
        while true {
            if self.haveBall {
                
                self.play()
                
                self.full.wait()
                self.mutex.wait()
            } else {
                
                self.takeBall()
                self.mutex.signal()
                self.empty.signal()
                
                self.play()
                
    
            }
        }
    }
    
    func play() {
        
        self.isPlaying = true
        
        let currentDate = Date()
        var i = 0
        
        while (Int(currentDate.timeIntervalSinceNow) != -playTime) {
            i += 1
        }
    }
    
    func doNothing() {
        self.isPlaying = false
    }
    
    func takeBall() {
        self.basket!.currentBalls -= 1
        self.haveBall = true
    }
    
    func putTheBall() {
        self.basket!.currentBalls += 1
        self.haveBall = false
    }
}
