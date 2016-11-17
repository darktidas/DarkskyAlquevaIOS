//
//  SubmenuButtonView.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 17/11/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit

class SubmenuButtonView: UIButton {

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
        let lineViewOne = UIView(frame: CGRect(x:0, y:60, width: largerSide, height:1))
        lineViewOne.backgroundColor = UIColor.white
        self.addSubview(lineViewOne)
    }
}
