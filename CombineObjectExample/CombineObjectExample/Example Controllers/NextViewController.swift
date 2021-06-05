//
//  NextViewController.swift
//  CombineObjectExample
//
//  Created by joser on 2021/6/5.
//  Copyright © 2021 zhang hang. All rights reserved.
//

import UIKit
import CombineObject

class NextViewController: UIViewController {

    lazy var v1: UIView = {
        let v = UIView(frame: .zero)
        return v
    }()
    
    lazy var changeButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("变橙色", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(self.change), for: .touchUpInside)
        return btn
    }()
    
    let bind:CombineBind<UIColor>
    
    init(_ bind:CombineBind<UIColor>) {
        self.bind = bind
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.view.addSubview(self.v1)
        self.v1.center = self.view.center
        self.v1.bounds = CGRect(x: 0, y: 0, width: 300, height: 300)
        
        self.view.addSubview(self.changeButton)
        self.changeButton.center = CGPoint(x: self.v1.center.x, y: self.v1.frame.maxY + 50)
        self.changeButton.bounds = CGRect(x: 0, y: 0, width: self.changeButton.intrinsicContentSize.width, height: self.changeButton.intrinsicContentSize.height)
        
        
        self.bind.bind(self.v1) { view, color in
            view.backgroundColor = color
        }
        
        // Do any additional setup after loading the view.
    }
    
    @objc func change() {
        self.bind.content = .orange
    }

}
