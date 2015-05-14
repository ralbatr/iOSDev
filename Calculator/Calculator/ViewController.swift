//
//  ViewController.swift
//  Calculator
//
//  Created by Ralbatr on 15/5/14.
//  Copyright (c) 2015年 ralbatr Yi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber:Bool = false
    
    @IBAction func appenDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber
        {
            display.text! += digit
        }else
        {
            display.text! = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        
        println("digit = \(digit)")
    }
    
}

