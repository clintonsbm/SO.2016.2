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
    
    var isStopped: Bool = false
    
    //Semaphores
    var mutex: DispatchSemaphore
    var empty: DispatchSemaphore
    var full: DispatchSemaphore
    
    //Text prompt
    var textPrompt: UITextView!
    
    //Kid images
    var playImage: UIImageView
    var waitImage: UIImageView
    var doNothingImage: UIImageView
    
    init(id: Int, haveBall: Bool, playTime: Int, doNothingTime: Int, semaphores: [DispatchSemaphore], basket: Basket, textPrompt: UITextView, images: [UIImageView]) {
        self.id = id
        self.haveBall = haveBall
        self.playTime = playTime
        self.doNothingTime = doNothingTime
        
        self.mutex = semaphores[0]
        self.empty = semaphores[1]
        self.full = semaphores[2]
        
        self.basket = basket
        
        self.textPrompt = textPrompt
        
        self.playImage = images[0]
        self.waitImage = images[1]
        self.doNothingImage = images[2]
    }
    
    func startKid() {
        while !self.isStopped {
            if self.haveBall {
                
                DispatchQueue.main.async {
                    self.textPrompt.insertText("Kid \(self.id) have ball\n")
                    self.textPrompt.insertText("Kid \(self.id) play phase\n")
                }
                
                self.play()
                
            } else {
                
                DispatchQueue.main.async {
                    self.textPrompt.insertText("Kid \(self.id) dont have ball\n")
                    self.textPrompt.insertText("Kid \(self.id) wait phase\n")
                    self.waitImage.isHidden = false
                }

                self.full.wait()
                self.mutex.wait()
                
                self.takeBall()
                
                self.mutex.signal()
                self.empty.signal()
                
                DispatchQueue.main.async {
                    self.waitImage.isHidden = true
                    self.textPrompt.insertText("Kid \(self.id) play phase\n")
                }
                
                self.play()
            }
            
            DispatchQueue.main.async {
                self.waitImage.isHidden = false
                self.textPrompt.insertText("Kid \(self.id) have ball\n")
                self.textPrompt.insertText("Kid \(self.id) try to return ball phase\n")
            }
            
            self.empty.wait()
            self.mutex.wait()
            
            DispatchQueue.main.async {
                self.waitImage.isHidden = true
                self.textPrompt.insertText("Kid \(self.id) place the ball phase\n")
            }
            
            self.putTheBall()
            
            self.mutex.signal()
            self.full.signal()
            
            DispatchQueue.main.async {
                self.textPrompt.insertText("Kid \(self.id) do nothing phase\n")
            }
            
            self.doNothing()
        }
        
        self.playImage.isHidden = true
        self.waitImage.isHidden = false
        self.doNothingImage.isHidden = true
    }
    
    func play() {
        
        DispatchQueue.main.async {
            self.playImage.isHidden = false
            self.textPrompt.insertText("Kid \(self.id) is playing\n")
        }
        
        self.isPlaying = true
        
        let currentDate = Date()
        var i = 0
        
        while (Int(currentDate.timeIntervalSinceNow) != Int(-self.playTime)) {
            i += 1
        }
        
        DispatchQueue.main.async {
            self.playImage.isHidden = true
            self.textPrompt.insertText("Kid \(self.id) stoped playing\n")
        }
    }
    
    func doNothing() {
        
        DispatchQueue.main.async {
            self.doNothingImage.isHidden = false
            self.textPrompt.insertText("Kid \(self.id) is doing nothing\n")
        }
        
        self.isPlaying = false
        
        let currentDate = Date()
        var i = 0
        
        while (Int(currentDate.timeIntervalSinceNow) != Int(-self.doNothingTime)) {
            i += 1
        }
        
        DispatchQueue.main.async {
            self.doNothingImage.isHidden = true
            self.textPrompt.insertText("Kid \(self.id) stoped doing nothing\n")
        }
    }
    
    func takeBall() {
        
        DispatchQueue.main.async {
            self.textPrompt.insertText("Kid \(self.id) taked ball\n")
        }
        
        self.basket!.currentBalls -= 1
        self.haveBall = true
    }
    
    func putTheBall() {
        
        DispatchQueue.main.async {
            self.textPrompt.insertText("Kid \(self.id) puted the ball\n")
        }
        
        self.basket!.currentBalls += 1
        self.haveBall = false
    }
}

extension Kid {
    ///Show on prompt function
    func showOnPrompt(text: String) {
        self.textPrompt.insertText("oi")
    }
}
