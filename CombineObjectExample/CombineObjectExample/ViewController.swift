//
//  ViewController.swift
//  CombineObjectExample
//
//  Created by zhang hang on 2019/8/2.
//  Copyright © 2019 zhang hang. All rights reserved.
//

import UIKit
import CombineObject


class ViewController: UIViewController {
    
    @CombineObjectBind
    var text:String = "Hello Word"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let label1 = UILabel()
        let label2 = UILabel()
        print(String.defaultCombineValue())
    }


}

