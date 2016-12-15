//
//  InstantiateKidView.swift
//  Trabalho SO
//
//  Created by Clinton de Sá Barreto Maciel on 14/12/16.
//  Copyright © 2016 clintonsbm. All rights reserved.
//

import UIKit

class InstantiateKidView: UIView {
    let pickerOptions = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]
    
    var playTime = 1
    
    var viewController: ViewController?
    
    var delegate: CreateKitDelegate?
    
    func setupView(in viewController: UIViewController, kidNumber: Int) {
        self.viewController = (viewController as! ViewController)
        self.delegate = self.viewController
        
        self.viewController?.kidLabel.text = "Kid \(kidNumber)"

        self.center = CGPoint(x: self.superview!
            .frame.midX, y: self.superview!.frame.midY)
        self.layer.cornerRadius = 10
        self.superview!.addSubview(self)
        self.transform = self.transform.scaledBy(x: 0.1, y: 0.1)
        self.alpha = 0
    }
    
    @IBAction func done(_ sender: Any) {
        self.delegate?.createKit(withBall: (self.viewController?.ballSwitch.isOn)!, playTime: self.playTime)
    }
    
}

extension InstantiateKidView: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerOptions.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(self.pickerOptions[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.playTime = self.pickerOptions[row]
    }
}


