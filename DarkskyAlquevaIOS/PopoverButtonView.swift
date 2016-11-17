//
//  PopoverButtonView.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 16/11/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit

class PopoverButtonView: UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupButtonStyle()
    }
    
    override init (frame: CGRect){
        super.init(frame: frame)
        setupButtonStyle()
    }
    
    func setupButtonStyle(){
        
        self.imageView?.contentMode = .scaleAspectFit
        self.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        self.contentHorizontalAlignment = .left
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -150, 0, 0)
    }
}
