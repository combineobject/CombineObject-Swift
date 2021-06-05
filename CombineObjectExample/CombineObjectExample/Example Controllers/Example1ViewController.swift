//
//  Example1ViewController.swift
//  CombineObjectExample
//
//  Created by joser on 2021/6/5.
//  Copyright © 2021 zhang hang. All rights reserved.
//

import UIKit
import CombineObject

class Example1ViewController: UIViewController {

    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var v2: UIView!
    
    @CombineObjectBind(UIColor.blue, CombineGlobalKey(key:"GlobaleColor"))
    var backgroundColor:UIColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.$backgroundColor.bind(self.v1) { view, color in
            view.backgroundColor = color
        }
        self.$backgroundColor.bind(self.v2) { view, color in
            view.backgroundColor = color
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func red(_ sender: Any) {
        self.backgroundColor = .red
    }
    
    @IBAction func yellow(_ sender: Any) {
        self.backgroundColor = .yellow
    }
    
    
    @IBAction func next(_ sender: Any) {
        
        let controller = NextViewController(self.$backgroundColor)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func pushModule(_ sender: Any) {
        let controller = ModuleViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
