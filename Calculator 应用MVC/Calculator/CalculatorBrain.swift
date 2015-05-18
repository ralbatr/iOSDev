//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Ralbatr on 15/5/15.
//  Copyright (c) 2015年 ralbatr Yi. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    enum Op {
        case Operand(Double)
        case UsaryOperation(String,Double -> Double)
        case BinaryOperation(String,(Double,Double) -> Double)
    }
//    var opStack = Array<ops>()
    var opStack = [Op]()
    
//    var knownOps = Dictionary<String,Op>()
    var knownOps = [String:Op]()
    
    init() {
//        knownOps["+"] = Op.BinaryOperation("+"){ $0 * $1 }
//        knownOps["−"] = Op.BinaryOperation("−"){ $1 * $0 }
//        knownOps["×"] = Op.BinaryOperation("×"){ $0 * $1 }
//        knownOps["÷"] = Op.BinaryOperation("÷"){ $1 / $0 }
//        knownOps["√"] = Op.UsaryOperation("√"){ sqrt($0) }
        
        knownOps["+"] = Op.BinaryOperation("+",+)
        knownOps["−"] = Op.BinaryOperation("−"){ $1 * $0 }
        knownOps["×"] = Op.BinaryOperation("×",*)
        knownOps["÷"] = Op.BinaryOperation("÷"){ $1 / $0 }
        knownOps["√"] = Op.UsaryOperation("√",sqrt)
    }
    
    func pushOperand(operand:Double) {
        opStack.append(Op.Operand(operand))
    }
    
    func performOperation(symbol:String) {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
    }
    
}