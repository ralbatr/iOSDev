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
    /*
    枚举没有继承，在后边加冒号":"，代表遵守协议protocol
    */
    private enum Op: Printable {
        case Operand(Double)
        case UnaryOperation(String,Double -> Double)
        case BinaryOperation(String,(Double,Double) -> Double)
        // Printable 协议
        var description: String {
            
            get {
                switch self
                {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let des, _):
                    return des
                case .BinaryOperation(let des,_):
                    return des
                }
            }
        }
    }
//    var opStack = Array<ops>()
    private var opStack = [Op]()
    
    private var TemporaryOpStack = [Op]()
    
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
    
    var program: AnyObject { // 保证是一个列表
        get {
            
//            return opStack.map($0.description)
            
            var returnValue = Array<String>()
            for op in opStack {
                returnValue.append(op.description)
            }
            return returnValue
        }
        set {
            if let opSymbols = newValue as? Array<String> {
                var newOpStack = [Op]()
                for opSymbol in opSymbols {
                    if let op = knownOps[opSymbol] {
                        newOpStack.append(op)
                    } else if let operand = NSNumberFormatter().numberFromString(opSymbol)?.doubleValue {
                        newOpStack.append(.Operand(operand))
                    }
                }
                opStack = newOpStack
            }
        }
    }
    /*
    类跟结构体的两大区别：
    1、类可以被继承，结构体不可以
    2、类传递的是地址，结构体传递的是值
    */
    private func evaluate(ops:[Op]) -> (result:Double?,remainingOps:[Op]) {
        
        if !ops.isEmpty
        {
            // 因为ops不可变，所以使用个中间变量
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
//        println("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    // 添加操作
    func pushOperand(operand:Double) -> Double? {
        opStack.append(Op.Operand(operand))
        if !TemporaryOpStack.isEmpty {
            var getOp = TemporaryOpStack.removeLast()
            opStack.append(getOp)
        }
        println("\(opStack)")
        return evaluate1()
    }
    
    func performOperation(symbol:String) {
        if let operation = knownOps[symbol] {
            TemporaryOpStack.append(operation)
        }
    }
    
}