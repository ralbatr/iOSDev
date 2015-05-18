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
//
    private enum Op {
        case Operand(Double)
        case UnaryOperation(String,Double -> Double)
        case BinaryOperation(String,(Double,Double) -> Double)
    }
//    var opStack = Array<ops>()
    private var opStack = [Op]()
    
//    var knownOps = Dictionary<String,Op>()
    private var knownOps = [String:Op]()
    
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
        knownOps["√"] = Op.UnaryOperation("√",sqrt)
    }
    /*
    类跟结构体的两大区别：
    1、类可以被继承，结构体不可以
    2、类传递的是地址，结构体传递的是值
    */
    private func evaluate(ops:[Op]) -> (result:Double?,remainingOps:[Op]) {
        
        if !ops.isEmpty
        {
            var remainingOps = ops;
            let op = remainingOps.removeLast()
            switch op
            {
                case .Operand(let operand):
                    return (operand,remainingOps)
                case .UnaryOperation(_, let operation):
                    let operandEvaluation = evaluate(remainingOps)
                    if let operand = operandEvaluation.result {
                        return (operation(operand), operandEvaluation.remainingOps)
                    }
                case .BinaryOperation(_, let operation):
                    let operand1Evaluation = evaluate(remainingOps)
                    if let operand1 = operand1Evaluation.result {
                        let operand2Evaluation = evaluate(operand1Evaluation.remainingOps)
                        if let operand2 = operand2Evaluation.result {
                            return (operation(operand1, operand2), operand2Evaluation.remainingOps)
                        }
                    }
                }
        }
        return (nil,ops)
    }
    
    func evaluate1() -> Double? {
        let (result, _) = evaluate(opStack)
        return result
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