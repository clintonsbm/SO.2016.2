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
    var basketLabel: UILabel
    
    //Label indicator
    var labelPlay: UILabel
    var labelDoNothing: UILabel
    
    //Kid images
    var playImage: UIImageView
    var waitForBallImage: UIImageView
    var waitForVacancyImage: UIImageView
    var doNothingImage: UIImageView
    
    init(id: Int, haveBall: Bool, playTime: Int, doNothingTime: Int, semaphores: [DispatchSemaphore], basket: Basket, textPrompt: UITextView, images: [UIImageView], basketLabel: UILabel, activity: [UILabel]) {
        self.id = id
        self.haveBall = haveBall
        self.playTime = playTime
        self.doNothingTime = doNothingTime
        
        self.mutex = semaphores[0]
        self.empty = semaphores[1]
        self.full = semaphores[2]
        
        self.basket = basket
        
        self.textPrompt = textPrompt
        self.basketLabel = basketLabel
        
        self.labelPlay = activity[0]
        self.labelDoNothing = activity[1]
        
        self.playImage = images[0]
        self.waitForBallImage = images[1]
        self.waitForVacancyImage = images[2]
        self.doNothingImage = images[3]
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
                    self.waitForBallImage.isHidden = false
                }

                self.full.wait()
                self.mutex.wait()
                
                self.takeBall()
                
                self.mutex.signal()
                self.empty.signal()
                
                DispatchQueue.main.async {
                    self.waitForBallImage.isHidden = true
                    self.textPrompt.insertText("Kid \(self.id) play phase\n")
                }
                
                self.play()
            }
            
            DispatchQueue.main.async {
                self.waitForVacancyImage.isHidden = false
                self.textPrompt.insertText("Kid \(self.id) have ball\n")
                self.textPrompt.insertText("Kid \(self.id) try to return ball phase\n")
            }
            
            self.empty.wait()
            self.mutex.wait()
            
            DispatchQueue.main.async {
                self.waitForVacancyImage.isHidden = true
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
        self.waitForBallImage.isHidden = false
        self.waitForVacancyImage.isHidden = false
        self.doNothingImage.isHidden = true
    }
    
    func play() {
        
        DispatchQueue.main.async {
            self.playImage.isHidden = false
            self.labelPlay.isHidden = false
            self.textPrompt.insertText("Kid \(self.id) is playing\n")
        }
        
        self.isPlaying = true
        
        let currentDate = Date()
        var i = 0
        
        var lastValue = 0
        
        while (Int(currentDate.timeIntervalSinceNow) != Int(-self.playTime)) {
            i += 1
            
            let value = Int(i/1000000)
            
            if value != lastValue {
                DispatchQueue.main.async {
                    self.labelPlay.text = "\(value)"
                }
                
                print("\(value) and \(lastValue)")
            }
            
            lastValue = value
            
            if i > 100000000 {
                i = 0
            }
        }
        
        DispatchQueue.main.async {
            self.playImage.isHidden = true
            self.labelPlay.isHidden = true
            self.textPrompt.insertText("Kid \(self.id) stoped playing\n")
        }
    }
    
    func doNothing() {
        
        DispatchQueue.main.async {
            self.doNothingImage.isHidden = false
            self.labelDoNothing.isHidden = false
            self.textPrompt.insertText("Kid \(self.id) is doing nothing\n")
        }
        
        self.isPlaying = false
        
        let currentDate = Date()
        
        var i = 0
        
        var lastValue = 0
        
        while (Int(currentDate.timeIntervalSinceNow) != Int(-self.doNothingTime)) {
            i += 1
            
            let value = Int(i/1000000)
            
            if value != lastValue {
                DispatchQueue.main.async {
                    self.labelDoNothing.text = "\(value)"
                }
                
                print("\(value) and \(lastValue)")
            }
            
            lastValue = value
            
            if i > 100000000 {
                i = 0
            }
        }
        
        DispatchQueue.main.async {
            self.doNothingImage.isHidden = true
            self.labelDoNothing.isHidden = true
            self.textPrompt.insertText("Kid \(self.id) stoped doing nothing\n")
        }
    }
    
    func takeBall() {
        
        DispatchQueue.main.async {
            self.textPrompt.insertText("Kid \(self.id) taked ball\n")
        }
        
        //self.basket!.currentBalls -= 1
        self.basket!.takeBall()
        self.haveBall = true
    }
    
    func putTheBall() {
        
        DispatchQueue.main.async {
            self.textPrompt.insertText("Kid \(self.id) puted the ball\n")
        }
        
        //self.basket!.currentBalls += 1
        self.basket!.placeBall()
        self.haveBall = false
    }
}

extension Kid {
    ///Show on prompt function
    func showOnPrompt(text: String) {
        self.textPrompt.insertText("oi")
    }
}
