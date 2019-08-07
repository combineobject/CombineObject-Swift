//
//  CombineSliderViewController.swift
//  CombineObjectExample
//
//  Created by 张行 on 2019/8/6.
//  Copyright © 2019 zhang hang. All rights reserved.
//

import UIKit
import CombineObject

class CombineSliderViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    @CombineObjectBind
    var text = "滑动更改这里的值"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayLabel.bind(combineObject: self._text)
        
    }

    @IBAction func change(_ sender: Any) {
        if let slider = sender as? UISlider {
            self.text = "\(slider.value)"
        }
    }
    
}
