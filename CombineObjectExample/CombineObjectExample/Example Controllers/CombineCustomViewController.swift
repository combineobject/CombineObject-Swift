//
//  CombineCustomViewController.swift
//  CombineObjectExample
//
//  Created by 张行 on 2019/8/6.
//  Copyright © 2019 zhang hang. All rights reserved.
//

import UIKit
import CombineObject

class CombineCustomViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var displayView: UIView!
    @CombineObjectBind
    var color = UIColor.gray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._color.bind.combineValueChangedBlock {[weak self] (value) in
            if let boardColor = value as? UIColor {
                self?.displayLabel.layer.borderWidth = 1
                self?.displayLabel.layer.borderColor = boardColor.cgColor
            }
        }
        self.displayLabel.bind(identifier: UILabelIdentifier.textColor, combineObject: self._color)
        self.displayView.bind(combineObject: self._color)
    }
    @IBAction func changeValue(_ sender: Any) {
        self.color = UIColor.red
    }
    @IBAction func changeView(_ sender: Any) {
        self.displayView.updateBindValue(value: UIColor.blue)
    }
}
