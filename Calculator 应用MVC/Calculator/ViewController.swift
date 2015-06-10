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
        // 添加 算法符号 加减乘除
        // 如果用户之前输入的是数字，把数字推入到堆栈中
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        // 如果用户之前输入的是运算符号
        if let opetation = sender.currentTitle {
            brain.performOperation(opetation)
        }
        
    }
    // 数据类型的转换
    var dispalyValue:Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)";
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    // 回车
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(dispalyValue) {
            dispalyValue = result
        } else {
            display.text = "Error"
        }
    }

}

