//
//  CombineTextFiledViewController.swift
//  CombineObjectExample
//
//  Created by 张行 on 2019/8/6.
//  Copyright © 2019 zhang hang. All rights reserved.
//

import UIKit
import CombineObject

class CombineTextFiledViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var displayLabel: UILabel!
    @CombineObjectBind
    var text = "输入内容改变这里的内容"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayLabel.bind(combineObject: self._text)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let content = textField.text as NSString? {
            let _content = content.replacingCharacters(in: range, with: string)
            self.text = String(_content)
        }
        return true
    }
}
