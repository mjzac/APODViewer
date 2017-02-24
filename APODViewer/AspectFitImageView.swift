//
//  AspectFitImageView.swift
//  APODViewer
//
//  Created by Melson Zacharias on 24/02/17.
//  Copyright © 2017 Perleybrook Labs LLC. All rights reserved.
//

import Cocoa

class AspectFitImageView: NSImageView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    override func awakeFromNib() {
        self.layer?.contentsGravity = kCAGravityResizeAspect
        self.wantsLayer = true
    }
}
