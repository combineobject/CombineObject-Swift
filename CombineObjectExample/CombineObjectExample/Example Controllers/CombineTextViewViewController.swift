//
//  CombineTextViewViewController.swift
//  CombineObjectExample
//
//  Created by 张行 on 2019/8/7.
//  Copyright © 2019 zhang hang. All rights reserved.
//

import UIKit
import CombineObject

class CombineTextViewViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var displayLabel: UILabel!
    @CombineObjectBind
    var state = "输入内容改变这里的值"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayLabel.bind(combineObject: self._state)
    }
    // MARK: UITextViewDelegate
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let content = textView.text as NSString? {
            let _content = content.replacingCharacters(in: range, with: text)
            self.state = String(_content)
        }
        return true
    }
}
