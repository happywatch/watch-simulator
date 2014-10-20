//
//  GradientGenerator.swift
//  WatchSimulator
//
//  Created by Ben Morrow on 10/12/14.
//
//  The most up-to-date version of this file is hosted at https://gist.github.com/benmorrow/aa3484dd3128875afbc0
//

import UIKit

enum Color {
    case Turquoise, Sky, Submerged, Emergency, Lilac, Brittany
}

extension CAGradientLayer {
    
    func generate(color: Color) -> CAGradientLayer {
        
        var topColor: UIColor
        var bottomColor: UIColor
        
        switch color {
        case .Turquoise:
            topColor = UIColor(red: (15/255.0), green: (118/255.0), blue: (128/255.0), alpha: 1)
            bottomColor = UIColor(red: (84/255.0), green: (187/255.0), blue: (187/255.0), alpha: 1)
        case .Sky:
            topColor = UIColor(red: (29/255.0), green: (119/255.0), blue: (239/255.0), alpha: 1)
            bottomColor = UIColor(red: (129/255.0), green: (243/255.0), blue: (253/255.0), alpha: 1)
        case .Submerged:
            topColor = UIColor(red: (26/255.0), green: (214/255.0), blue: (253/255.0), alpha: 1)
            bottomColor = UIColor(red: (29/255.0), green: (98/255.0), blue: (240/255.0), alpha: 1)
        case .Emergency:
            topColor = UIColor(red: (255/255.0), green: (59/255.0), blue: (48/255.0), alpha: 1)
            bottomColor = UIColor(red: (0/255.0), green: (122/255.0), blue: (255/255.0), alpha: 1)
        case .Lilac:
            topColor = UIColor(red: (200/255.0), green: (110/255.0), blue: (223/255.0), alpha: 1)
            bottomColor = UIColor(red: (228/255.0), green: (183/255.0), blue: (240/255.0), alpha: 1)
        case .Brittany:
            topColor = UIColor(red: (85/255.0), green: (239/255.0), blue: (203/255.0), alpha: 1)
            bottomColor = UIColor(red: (91/255.0), green: (202/255.0), blue: (255/255.0), alpha: 1)
        }
        
        let gradientColors: Array <AnyObject> = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations: Array <AnyObject> = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        return gradientLayer
    }
}

/*

//
//  In your view controller:
//  (ViewController.swift)
//  Use these two functions to draw the multicolor background. Replace the color name with your choice.
//

override func viewWillAppear(animated: Bool) {
initAppearance()
}

func initAppearance() {
let background = CAGradientLayer().generate(.Turquoise)
background.frame = self.view.bounds
self.view.layer.insertSublayer(background, atIndex: 0)
}

*/
