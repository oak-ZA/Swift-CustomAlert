//
//  TostView.swift
//  SwiftTost
//
//  Created by 张奥 on 2020/4/1.
//  Copyright © 2020 张奥. All rights reserved.
//

import Foundation
import UIKit


public enum AlertErro : Error{
    case superViewIsNil
}

public class Alert : NSObject {
    
    typealias confirmClose = (Bool) -> Void
    typealias censureClose = (Bool) -> Void
    
    
    public static let shared = Alert()
    
    var backGroundView : UIView!
    //bgView
    var bgView : UIView!
    //titleLab
    var titleLab : UILabel!
    //confirmButton
    var confirmButton : UIButton!
    //censureButton
    var censureButton : UIButton!
    
    var confirmBlock : confirmClose?
    var censureBlock : censureClose?
    
    class  func showAlertView(superView:UIView?,text:String?,confirmClose:@escaping((Bool)-> Void),censureClose:@escaping(Bool)->Void) throws -> Void {
        
        guard superView != nil || text != nil else {
            throw AlertErro.superViewIsNil
        }
        shared.confirmBlock = confirmClose
        shared.censureBlock = censureClose
        
        shared.backGroundView = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        shared.backGroundView.backgroundColor = UIColor.black.withAlphaComponent(0.54)
        superView?.addSubview(shared.backGroundView);
        
        shared.bgView = UIView()
        shared.bgView.backgroundColor = UIColor.white
        shared.bgView.layer.masksToBounds = true
        shared.bgView.layer.cornerRadius = 20.0
        shared.bgView.alpha = 0.0
        shared.backGroundView.addSubview(shared.bgView)
        shared.bgView.snp.makeConstraints { (make) in
            make.center.equalTo(shared.backGroundView)
            make.width.equalTo(310.0)
            make.height.equalTo(165.0)
        }
        shared.bgView.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5);
        UIView.animate(withDuration: 0.25) {
            shared.bgView.alpha = 1.0
            shared.bgView.transform = CGAffineTransform.identity;
        };
        
        shared.titleLab = UILabel()
        shared.titleLab?.textColor = UIColor.black
        shared.titleLab?.font = UIFont.systemFont(ofSize: 15.0)
        shared.titleLab?.textAlignment = NSTextAlignment.center
        shared.titleLab.numberOfLines = 0;
        shared.bgView.addSubview(shared.titleLab)
        shared.titleLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(shared.bgView)
            make.top.equalTo(shared.bgView.snp.top).offset(28)
            make.left.equalTo(shared.bgView.snp.left).offset(8)
            make.right.equalTo(shared.bgView.snp.right).offset(-8)
        }
        let paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        paragraphStyle.alignment = NSTextAlignment.center
        let attributedString = NSMutableAttributedString.init(string: text!, attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle])
        shared.titleLab.attributedText = attributedString;
        
        
        
        let line = UIView()
        line.backgroundColor = UIColor.gray
        shared.bgView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.right.equalTo(shared.bgView)
            make.bottom.equalTo(shared.bgView.snp.bottom).offset(-50)
            make.height.equalTo(0.5)
        }
        
        
        shared.confirmButton = UIButton(type: UIButton.ButtonType.custom)
        shared.confirmButton.setTitle("是", for: UIControl.State.normal)
        shared.confirmButton.setTitleColor(UIColor.red, for: UIControl.State.normal)
        shared.confirmButton.addTarget(shared, action: #selector(clickConfirmButton(button:)), for: UIControl.Event.touchUpInside)
        shared.bgView.addSubview(shared.confirmButton)
        shared.confirmButton.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(shared.bgView)
            make.width.equalTo(310/2)
            make.height.equalTo(50)
        }
        
        shared.censureButton = UIButton(type: UIButton.ButtonType.custom)
        shared.censureButton.setTitle("否", for: UIControl.State.normal)
        shared.censureButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        shared.censureButton.addTarget(shared, action: #selector(clickCensureButton(button:)), for: UIControl.Event.touchUpInside)
        shared.bgView.addSubview(shared.censureButton)
        shared.censureButton.snp.makeConstraints { (make) in
            make.bottom.left.equalTo(shared.bgView)
            make.width.equalTo(310/2)
            make.height.equalTo(50)
        }

    }

    
    @objc func clickConfirmButton(button:UIButton) {
        self.backGroundView.removeFromSuperview();
        self.confirmBlock?(true)
    }
    @objc func clickCensureButton(button:UIButton) {
        self.backGroundView.removeFromSuperview();
        self.censureBlock?(true)
    }
}



private extension UIView {
    
    var csSafeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return self.safeAreaInsets
        } else {
            return .zero
        }
    }
    
}
