//
//  MapLegendView.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 17/11/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import UIKit

class MapLegendView: UIView {
    
    var titleLabel: UILabel!
    var markerOneTitle: UILabel!
    var markerOneImageView: UIImageView!
    var markerTwoTitle: UILabel!
    var markerTwoImageView: UIImageView!
    var markerThreeTitle: UILabel!
    var markerThreeImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.addView()
    }
    
    func addView(){

        self.backgroundColor = UIColor(white: 1, alpha: 0.8)
        
        self.titleLabel = UILabel(frame: CGRect(x: 5, y: 5, width: 140, height: 20))
        self.titleLabel.font = self.titleLabel.font.withSize(14)
        self.titleLabel.textAlignment = .center
        self.addSubview(self.titleLabel)

        
        self.markerOneImageView = UIImageView(frame: CGRect(x: 10, y: 30, width: 40, height: 40))
        self.markerOneImageView.contentMode = .scaleAspectFit
        self.markerOneTitle = UILabel(frame: CGRect(x: 55, y: 40, width: 120, height: 20))
        self.markerOneTitle .font = self.markerOneTitle .font.withSize(13)
        self.addSubview(self.markerOneImageView)
        self.addSubview(self.markerOneTitle )
        
        self.markerTwoImageView = UIImageView(frame: CGRect(x: 10, y: 65, width: 40, height: 40))
        self.markerTwoImageView.contentMode = .scaleAspectFit
        self.markerTwoTitle  = UILabel(frame: CGRect(x: 55, y: 75, width: 120, height: 20))
        self.markerTwoTitle .font = self.markerTwoTitle .font.withSize(13)
        self.addSubview(self.markerTwoImageView)
        self.addSubview(self.markerTwoTitle )
        
        self.markerThreeImageView = UIImageView(frame: CGRect(x: 10, y: 100, width: 40, height: 40))
        self.markerThreeImageView.contentMode = .scaleAspectFit
        self.markerThreeTitle  = UILabel(frame: CGRect(x: 55, y: 110, width: 120, height: 20))
        self.markerThreeTitle .font = self.markerThreeTitle .font.withSize(13)
        self.addSubview(self.markerThreeImageView)
        self.addSubview(self.markerThreeTitle )
    }
}
