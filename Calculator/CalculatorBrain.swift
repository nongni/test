//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Jitta Sae Lee on 9/17/2560 BE.
//  Copyright © 2560 Jitta Sae Lee. All rights reserved.
//

import Foundation


struct CalculatorBrain{
    
    init(){
        accumulator = 10
    }
    
    private var accumulator: Double
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(Double.pi),
        "e" : Operation.Constant(M_E) ,
        "√" :Operation.UnaryOperation(sqrt),
        "cos"   : Operation.UnaryOperation(cos),
        "×"   : Operation.BinaryOperation({ $0 * $1 }),
        " "   : Operation.BinaryOperation({$0 / $1 }),
        "+"   : Operation.BinaryOperation({$0 + $1 }),
        "-"   : Operation.BinaryOperation({$0 - $1 }),
        "±"   : Operation.BinaryOperation({$0 - $1 }),
        "="   : Operation.Equals,
        ]
    
    struct PendingBinaryOperandInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    private var pending: PendingBinaryOperandInfo?
    
    mutating func performanceOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                pending = PendingBinaryOperandInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                if pending != nil {
                    accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
                    pending = nil
                }
            }
            
        }
        
    }
    
    
    
             mutating func setOperand(operand: String) {
                accumulator = Double( operand)!
            }
    
            var result: Double? {
                get{
                    return accumulator
                }
            }
    
    
}
