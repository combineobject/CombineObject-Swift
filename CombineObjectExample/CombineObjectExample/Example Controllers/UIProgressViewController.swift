//
//  UIProgressViewController.swift
//  CombineObjectExample
//
//  Created by 张行 on 2019/8/6.
//  Copyright © 2019 zhang hang. All rights reserved.
//

import UIKit
import CombineObject

class UIProgressViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var displayLabel: UILabel!
    @CombineObjectBind
    var progress:Float = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self._progress.bind.combineValueChangedBlock { (value) in
            guard let _value = value as? Float else {
                return
            }
            self.displayLabel.text = "\(_value)"
        }
        self.progressView.bind(combineObject: self._progress)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.add()
        }
    }
    
    func add() {
        self.progress += 0.1
        if self.progress >= 1 {
            self.progress = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.remove()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.add()
            }
        }
    }
    
    func remove() {
        self.progress -= 0.1
        if self.progress <= 0 {
            self.progress = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.add()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.remove()
            }
        }
    }

}
