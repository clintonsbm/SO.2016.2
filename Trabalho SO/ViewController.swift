//
//  ViewController.swift
//  Trabalho SO
//
//  Created by Clinton de Sá Barreto Maciel on 14/12/16.
//  Copyright © 2016 clintonsbm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var basketSize: Int?
    
    var basket: Basket? = nil
    
    var kidsArray: [Kid] = []
    
    var instantiateKidView = InstantiateKidView()
    
    //InstantiateKidView propreties
    @IBOutlet weak var kidLabel: UILabel!
    
    @IBOutlet weak var ballSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.basket = Basket(size: self.basketSize!)
    }

    @IBAction func zzzzz(_ sender: Any) {
        self.instantiateKidView.setupView(in: self, kidNumber: self.kidsArray.count+1)
    }
}

extension ViewController: CreateKitDelegate {
    func createKit(withBall: Bool, playTime: Int) {
        print("Instantiate kid")
    }
}
