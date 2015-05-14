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
        switch opetation  {
            case "×" :
                // 直接写
                if operandStack.count == 2 {
                    dispalyValue  = operandStack.removeLast()*operandStack.removeLast()
                    enter()
                }
            
            case "÷" :
                // 传递 方法名
                performOperation(divide)
            
            case "+" :
                // 闭包实现
                performOperation({ (op1:Double, op2:Double) -> Double in
                    return op1 + op2
                })
            case "−" :
                // 闭包实现，自动推断
                /*
                performOperation({ (op1, op2) -> Double in
                return op1 + op2
                })
                
               
                performOperation({ (op1, op2) ->  in op1 + op2
                })
                
                performOperation({ $1 - $0 })
                
                
                performOperation(){ $1 - $0 }
                */
                performOperation { $1 - $0 }
            case "√":
                performOperation1 { sqrt($0) }
            default: break
        }
    }
    
    func performOperation(operation:(Double,Double)->Double)
    {
        if operandStack.count == 2 {
            dispalyValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    // 理论上可以根据参数判定那个参数，但是此处老是报错，所以改了一下名字
    func performOperation1 (operation:Double -> Double)
    {
        if operandStack.count >= 1 {
            dispalyValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    func divide(op1:Double,op2:Double)->Double {
        return op2/op1
    }
//    var operandStack:Array<Double> =  Array<Double>()
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
        operandStack.append(dispalyValue)
        println("operationStack = \(operandStack)")
    }
    
    
    
}

