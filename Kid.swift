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
    
    let doNothingTime: Int
    
    var isPlaying: Bool?
    
    let basket: Basket?
    
    //Semaphores
    var mutex: DispatchSemaphore
    var empty: DispatchSemaphore
    var full: DispatchSemaphore
    
    init(id: Int, haveBall: Bool, playTime: Int, doNothingTime: Int, semaphores: [DispatchSemaphore], basket: Basket) {
        self.id = id
        self.haveBall = haveBall
        self.playTime = playTime
        self.doNothingTime = doNothingTime
        
        self.mutex = semaphores[0]
        self.empty = semaphores[1]
        self.full = semaphores[2]
        
        self.basket = basket
    }
    
    func startKid() {
        while true {
            if self.haveBall {
                
                print("Kid \(self.id) have ball")
                print("Kid \(self.id) play phase")
                self.play()
                
            } else {
                
                print("Kid \(self.id) dont have ball")
                print("Kid \(self.id) wait phase")
                self.full.wait()
                self.mutex.wait()
                
                self.takeBall()
                
                self.mutex.signal()
                self.empty.signal()
                
                print("Kid \(self.id) taked ball")
                print("Kid \(self.id) play phase")
                self.play()
            }
            
            print("Kid \(self.id) have ball")
            print("Kid \(self.id) try to return ball phase")
            self.empty.wait()
            self.mutex.wait()
            
            print("Kid \(self.id) place the ball phase")
            self.putTheBall()
            
            self.mutex.signal()
            self.full.signal()
            
            print("Kid \(self.id) do nothing phase")
            self.doNothing()
        }
    }
    
    func play() {
        print("Kid \(self.id) is playing")
        self.isPlaying = true
        
        let currentDate = Date()
        var i = 0
        
        while (Int(currentDate.timeIntervalSinceNow) != Int(-self.playTime)) {
            i += 1
        }
        
        print("Kid \(self.id) stoped playing ")
    }
    
    func doNothing() {
        print("Kid \(self.id) is doing nothing")
        self.isPlaying = false
        
        let currentDate = Date()
        var i = 0
        
        while (Int(currentDate.timeIntervalSinceNow) != Int(-self.doNothingTime)) {
            i += 1
        }
        
        print("Kid \(self.id) stoped doing nothing")
    }
    
    func takeBall() {
        print("Kid \(self.id) taked ball")
        self.basket!.currentBalls -= 1
        self.haveBall = true
    }
    
    func putTheBall() {
        print("Kid \(self.id) puted the ball")
        self.basket!.currentBalls += 1
        self.haveBall = false
    }
}
