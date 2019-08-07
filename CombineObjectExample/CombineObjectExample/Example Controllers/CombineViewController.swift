//
//  LabelViewController.swift
//  CombineObjectExample
//
//  Created by 张行 on 2019/8/5.
//  Copyright © 2019 zhang hang. All rights reserved.
//

import UIKit
import CombineObject

class CombineViewController: UIViewController {
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var displayView: UIView!
    @CombineObjectBind
    var color = UIColor.gray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayLabel.bind(identifier: UILabelIdentifier.textColor, combineObject: self._color)
        self.displayView.bind(combineObject: self._color)
    }
    
    @IBAction func changeValue(_ sender: Any) {
        self.color = UIColor.red
    }
    @IBAction func changeView(_ sender: Any) {
        self.displayView.updateBindValue(value: UIColor.blue)
    }
    
    deinit {
        print("CombineViewController")
    }
}
