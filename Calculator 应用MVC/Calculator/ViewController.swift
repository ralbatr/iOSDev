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
    
    var brain = CalculatorBrain()
    
    @IBAction func appenDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber
        {
            display.text = display.text! + digit
        }else
        {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    // 操作符
    @IBAction func operate(sender: UIButton) {
        let opetation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber
        {
            enter()
        }
        
    }

    var operandStack =  Array<Double>()
    
    var dispalyValue:Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)";
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        brain.pushOperand(dispalyValue)
    }
    
    
    
}

