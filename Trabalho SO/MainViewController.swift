//
//  ViewController.swift
//  Trabalho SO
//
//  Created by Clinton de Sá Barreto Maciel on 14/12/16.
//  Copyright © 2016 clintonsbm. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var basketSize: Int?
    
    var basket: Basket? = nil
    
    var kidsArray: [Kid] = []
    
    //InstantiateKidView propreties
    @IBOutlet var instantiateKidView: UIView!
    
    @IBOutlet weak var kidLabel: UILabel!
    @IBOutlet weak var ballSwitch: UISwitch!
    @IBOutlet weak var playPicker: UIPickerView!
    @IBOutlet weak var spendPicker: UIPickerView!
    
    let pickerOptions = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]
    
    var playTime = 1
    var spendTime = 1
    
    //Semaphores
    var mutex = DispatchSemaphore(value: 1)
    var empty: DispatchSemaphore?
    var full = DispatchSemaphore(value: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.playPicker.delegate = self
        self.playPicker.dataSource = self
        
        self.spendPicker.delegate = self
        self.spendPicker.dataSource = self
        
        self.basket = Basket(size: self.basketSize!)
        self.empty = DispatchSemaphore(value: self.basketSize!)
    }

    @IBAction func callInstantiateKidView(_ sender: UIButton) {
        self.setupView()
    }
}

extension MainViewController {
   
    ///Semaphore code
    @IBAction func startAplication(_ sender: Any) {
        for kid in self.kidsArray {
            let _ = DispatchQueue(label: "\(kid.id)").async {
                kid.startKid()
            }
        }
    }
}

extension MainViewController {
    
    ///IntantiateKidView functions
    @IBAction func doneInstantiatingKid(_ sender: UIButton) {
        let kid = Kid(id: self.kidsArray.count+1, haveBall: self.ballSwitch.isOn, playTime: self.playTime, doNothingTime: self.spendTime, semaphores: [self.mutex, self.empty!, self.full], basket: self.basket!)
        
        self.kidsArray.append(kid)
        
        self.instantiateKidView.removeFromSuperview()
        
        let _ = DispatchQueue(label: "\(kid.id)").async {
            kid.startKid()
        }
    }
    
    func setupView() {
        
        self.kidLabel.text = "Kid \(self.kidsArray.count+1)"
        
        self.instantiateKidView.center = CGPoint(x: self.view
            .frame.midX, y: self.view.frame.midY)
        self.instantiateKidView.layer.cornerRadius = 10
        self.view.addSubview(self.instantiateKidView)
        self.instantiateKidView.alpha = 1
    }

}

extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        
        if pickerView == self.playPicker{
            self.playTime = self.pickerOptions[row]
        } else {
            self.spendTime = self.pickerOptions[row]
        }
    }

}
