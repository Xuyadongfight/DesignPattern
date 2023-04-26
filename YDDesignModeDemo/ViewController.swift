//
//  ViewController.swift
//  YDDesignModeDemo
//
//  Created by 徐亚东 on 2022/10/21.
//

import UIKit

class ViewController: UIViewController{

    let curDesignPattern = DesignPattern.Structural.Bridge
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.curDesignPattern.start()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        DesignPattern.Creational.testAll()
        DesignPattern.Structural.testAll()
        DesignPattern.Behavioral.testAll()
    }
    
}



