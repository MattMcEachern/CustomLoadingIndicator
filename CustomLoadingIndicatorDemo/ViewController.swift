//
//  ViewController.swift
//  CustomLoadingIndicatorDemo
//
//  Created by Matt McEachern on 8/16/15.
//  Copyright (c) 2015 Matt McEachern. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        let loadingLabel = UILabel(frame: CGRect(x: 0,y: 0,width: self.view.bounds.width, height: 100.0))
        loadingLabel.text = "LOADING"
        loadingLabel.textColor = UIColor.blackColor()
        loadingLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(loadingLabel)
        loadingLabel.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 55.0);
        
        let customLoadingIndicator = CustomLoadingIndicator()
        self.view.addSubview(customLoadingIndicator)
        customLoadingIndicator.center = self.view.center
        customLoadingIndicator.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

