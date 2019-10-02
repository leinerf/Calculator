//
//  ViewController.swift
//  calculator
//
//  Created by Freniel Zabala on 9/29/19.
//  Copyright © 2019 Freniel Zabala. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var outputValue: UILabel!
    
    var hasDecimal = false
    var numbersInputted = [Double]()
    var operationsInputted = [Int]()
    var resetInput = false
    var operationChosen = -1
    
    let numbers = [
        100: "7",101: "8",102: "9",
        200: "4",201: "5",202: "6",
        300: "1",301: "2",302: "3",
        400: "0", 401:"."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //Mark: Actions
    @IBAction func OnPressCalc(_ sender: UIButton) {
        //reset if necessary
        if isAnOperation(tag: sender.tag){
            print(numbersInputted)
            print(operationsInputted)
            operationChosen = sender.tag
            //execute previous stuff
            if numbersInputted.count > 0 && operationsInputted.count > 0 {
                
                if operationChosen == 402 {
                    executeCalculation(stop: numbersInputted.count)
                }
                else if numbersInputted.count == 2 && operationsInputted.count == 2 && [203, 303].contains(operationChosen){
                    executeCalculation(stop: 2)
                }
                else if ![203, 303].contains(operationsInputted.last) || ![003, 103].contains(operationChosen){
                    executeCalculation(stop: 1)
                }
            }
            
            
        }
        else if sender.tag == 000 {
            numbersInputted.removeAll()
            operationsInputted.removeAll()
            outputValue.text = "0"
        }
        else if sender.tag == 001 {
            var saveNum = Double(outputValue.text ?? "0")!
            saveNum = -1 * saveNum
            outputValue.text = String(saveNum)
        }
        
        else {
            if operationChosen != -1{
                //save previous num
                let saveNum = Double(outputValue.text ?? "0")!
                
                if operationChosen != 402 {
                    numbersInputted.append(saveNum)
                    operationsInputted.append(operationChosen)
                }
                outputValue.text = "0"
                hasDecimal = false
                operationChosen = -1
            }
            appendNumber(tag: sender.tag)
        }
        
    }
    
    func isAnOperation(tag: Int) -> Bool{
        return [003, 103, 203, 303, 402].contains(tag)
    }
    
    func performOperation(left: Double, right: Double, operation: Int) -> Double {
        
        if operation == 003 {
            //divide
            return  left / right
        }
        else if operation == 103 {
            //multiply
            return left * right
        }
        else if operation == 203 {
            //subtract
            return left - right
        }
        else {
            //add
            return left + right
        }
    }
    
    func executeCalculation(stop: Int){
        var counter = 0
        var currentNum = Double(outputValue.text!)!
        
        while counter < stop {
            let prevNum = numbersInputted.removeLast()
            let prevOperation = operationsInputted.removeLast()
            currentNum = performOperation(left: prevNum, right: currentNum, operation: prevOperation)
            print(currentNum)
            counter += 1
        }
        if floor(currentNum) == currentNum {
                outputValue.text = String(Int(currentNum))
        } else {
            outputValue.text = String(currentNum)
        }
    }
    
    func appendNumber(tag: Int) {
        let currentNumber: String;
        //edge case of currentNumber is 0 then don't add it
        if ((outputValue?.text) != nil) && (tag == 401 || outputValue.text != "0")   {
            currentNumber = outputValue.text!
        }
        else {
            currentNumber = ""
        }
        let appendNumber = String(numbers[tag] ?? "")
        //edge case of adding a decimal
        if tag == 401  {
            if !hasDecimal {
                outputValue.text = "\(currentNumber)\(appendNumber)"
                hasDecimal = true
            }
        }
        else {
            outputValue.text = "\(currentNumber)\(appendNumber)"
        }
    }
}
