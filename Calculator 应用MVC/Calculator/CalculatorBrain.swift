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
        case Operation(String,Double -> Double)
        case SinaryOperation(Double,Double -> Double)
    }
//    var opStack = Array<ops>()
    var opStack = [Op]()
    
}