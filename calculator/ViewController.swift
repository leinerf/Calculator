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
            operationChosen = sender.tag
            //execute previous stuff
            if numbersInputted.count > 0 && operationsInputted.count > 0 {
                print(numbersInputted)
                print(operationsInputted)
                if ![203, 303].contains(operationsInputted.last) || ![003, 103].contains(operationChosen)
                {
                    print("it went here with \(operationsInputted.last)")
                    executeCalculation()
                }
            }
            
        } else {
            if operationChosen != -1{
                //save previous num
                let saveNum = Double(outputValue.text ?? "0")!
                numbersInputted.append(saveNum)
                if sender.tag != 403 {
                    operationsInputted.append(operationChosen)
                }
                outputValue.text = "0"
                operationChosen = -1
            }
            appendNumber(tag: sender.tag)
        }
        
    }
    
    func isAnOperation(tag: Int) -> Bool{
        return [003, 103, 203, 303, 403].contains(tag)
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
    
    func executeCalculation(){
        let currentNum = Double(outputValue.text!)!
        let prevNum = numbersInputted.removeLast()
        let prevOperation = operationsInputted.removeLast()
        outputValue.text = String(performOperation(left: prevNum, right: currentNum, operation: prevOperation))
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
    func executeMathCaclulation(){
        
    }
}
