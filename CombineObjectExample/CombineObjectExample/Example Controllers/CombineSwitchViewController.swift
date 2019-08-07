//
//  CombineSwitchViewController.swift
//  CombineObjectExample
//
//  Created by 张行 on 2019/8/7.
//  Copyright © 2019 zhang hang. All rights reserved.
//

import UIKit
import CombineObject

class CombineSwitchViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    @CombineObjectBind
    var state = "点击开关改变这里内容"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayLabel.bind(combineObject: self._state)
        // Do any additional setup after loading the view.
    }

    @IBAction func changed(_ sender: Any) {
        if let switchView = sender as? UISwitch {
            self.state = switchView.isOn ? "ON" : "OFF"
        }
    }
}
