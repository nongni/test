//
//  ViewController.swift
//  Calculator
//
//  Created by Jitta Sae Lee on 9/17/2560 BE.
//  Copyright © 2560 Jitta Sae Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isUSerKeyInData = false
    private var brain: CalculatorBrain = CalculatorBrain()
    
    @IBOutlet weak var output: UILabel!

    var displayValue: Double {
        get{
            return Double(output.text!)!
        }
        set {
            output.text = String(newValue)
        }
    }
    
    @IBAction func doPressNumeric(_ sender: UIButton) {
       
        let digit = sender.currentTitle!
        if isUSerKeyInData {
            output.text = output.text! + digit
            brain.setOperand(operand: output.text!)
        }else{
            output.text = digit
            //displayValue = digit
            brain.setOperand(operand: output.text!)
            isUSerKeyInData = true
        }
    
        print("\(digit) was click")
    }
    
    @IBAction func doPressFunctionMatch(_ sender: UIButton) {
        let funcMatch = sender.currentTitle!
        
        brain.performanceOperation(symbol: funcMatch)
        displayValue =   brain.result!
        
    }
}

