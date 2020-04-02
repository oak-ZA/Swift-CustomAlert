//
//  ViewController.swift
//  SwiftTost
//
//  Created by 张奥 on 2020/4/1.
//  Copyright © 2020 张奥. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    typealias close = ()
    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//
//        var aa =  passValue(name: "张奥", age: 20) { (name:String) in
//            print(name)
//        }
//        print(aa);
        
        
        
        var button = UIButton(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 10, y: 63, width: 60, height: 60)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(clickButton(button:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(button)
        
        
        
    }
//
//
//    func passValue(name:String,age:Int,completion:@escaping(String) -> Void) -> Int{
//
//        completion("嘻嘻😝")
//
//        return 20;
//
//    }
    
    
  @objc  func clickButton(button:UIButton) {
    
    do {
        try Alert.showAlertView(superView: self.view, text: "开启后，您将会在所有大V的亲密榜中隐身\n是否开启?", confirmClose: { (confim:Bool) in
            print("点击了确定")
        }, censureClose: { (censure:Bool) in
            print("点击了取消")
        })
    } catch AlertErro.superViewIsNil {
        print("superView is nil")
        
    }catch{}
    
    }
    
}

