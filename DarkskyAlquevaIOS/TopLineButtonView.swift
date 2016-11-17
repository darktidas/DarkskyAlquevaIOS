//
//  TopLineButtonView.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 17/11/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit

class TopLineButtonView: UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupButtonStyle()
    }
    
    override init (frame: CGRect){
        super.init(frame: frame)
        setupButtonStyle()
    }
    
    func setupButtonStyle(){
        
        let screenSize: CGRect = UIScreen.main.bounds
        var largerSide: CGFloat!
        
        if screenSize.width > screenSize.height{
            largerSide = screenSize.width
        }else{
            largerSide = screenSize.height
        }
        
        self.tintColor = .white        
        self.setTitleColor(UIColor.white, for: UIControlState.normal)
        let lineView = UIView(frame: CGRect(x:0, y:0, width: largerSide, height:1))
        lineView.backgroundColor=UIColor.white
        self.addSubview(lineView)
    }
}
