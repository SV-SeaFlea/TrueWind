//
//  TextInputManager.swift
//  VerticalSextantAngle
//
//  Created by pmoens on 25/11/20.
//  Copyright © 2020 pmoens. All rights reserved.
//

import UIKit
var inFeet: Bool = false

func updateTextField(_ sender: UITextField){
    if sender.text == "" { //if nothing is typed and the user exit the textfield without entering any string the values are set to 0
        switch sender.tag {
        case 0:
            calculatorManager.sextantAngle.degrees = 0
            calculatorManager.sextantAngle.isNegative = false
            sender.text = "0"
            break
        case 1:
            calculatorManager.sextantAngle.minutes = 0
            sender.text = "0"
        case 2:
            calculatorManager.heightOfEyes = 0.0
            sender.text = "0.0"
        case 3:
            calculatorManager.objectHeight = 0.0
            sender.text = "0.0"
        case 4:
            calculatorManager.distance = 0.0
            sender.text = "0.00"
        default:
            break
        }
    } else { //otherwise assign the value typed in the textfield to the corresponding variable
        switch sender.tag {
        case 0:
            var signString: String = ""
            if calculatorManager.sextantAngle.isNegative! {signString = "-"}
            sender.text = signString + String(format: "%01d", calculatorManager.sextantAngle.degrees ?? "0")
        case 1:
            sender.text = String(format: "%01d", calculatorManager.sextantAngle.minutes ?? "0")
        case 2:
            var heightOfEye: Double
            //all variable are stored in feet or nautical miles so if the values are entered inmeters, they are first converted to feet
            if !inFeet {
                heightOfEye = calculatorManager.feetToMeters(calculatorManager.heightOfEyes)
            }else{
                heightOfEye = calculatorManager.heightOfEyes
            }
            sender.text = String(format: "%.1f", heightOfEye)
        case 3:
            var objectHeight: Double
            if !inFeet {
                objectHeight = calculatorManager.feetToMeters(calculatorManager.objectHeight)
            }else{
                objectHeight = calculatorManager.objectHeight
            }
            sender.text = String(format: "%.1f", objectHeight)
        case 4:
            sender.text = String(format: "%.2f", calculatorManager.distance)
        default:
            break
        }
        
    }
    sender.resignFirstResponder()
}

func checkUserInput(_ textField: UITextField) -> Bool {
    let testValue = Double(textField.text ?? "0.0") ?? 0.0
    var correctInput: Bool = true
    switch textField.tag {
    case 0:
        if Int(testValue) > 30 || Int(testValue) <= -1{
            textField.text = "0"
            correctInput = false
        } else {
            calculatorManager.sextantAngle.degrees = Int(testValue)
            if String(testValue) == "-0.0" {
                calculatorManager.sextantAngle.isNegative = true
            } else {
                calculatorManager.sextantAngle.isNegative = false
            }
        }
    case 1:
        if Int(testValue) > 60 || Int(testValue) < 0 {
            textField.text = "0"
            correctInput = false
        } else {
            calculatorManager.sextantAngle.minutes = Int(testValue)
        }
    case 2:
        if Int(testValue) > 100 || Int(testValue) < 0 {
            textField.text = "0.0"
            correctInput = false
        } else {
            if !inFeet {
                calculatorManager.heightOfEyes = calculatorManager.metersToFeet(testValue)
            } else{
              calculatorManager.heightOfEyes = testValue
            }
        }
    case 3:
        if Int(testValue) > 3000 || Int(testValue) < 0 {
            textField.text = "0.0"
            correctInput = false
        } else {
            if !inFeet {
                calculatorManager.objectHeight = calculatorManager.metersToFeet(testValue)
            } else{
                calculatorManager.objectHeight = testValue
            }
        }
    case 4:
        if testValue > 50 || testValue < 0 {
            textField.text = "0.00"
            correctInput = false
        } else {
            calculatorManager.distance = testValue
        }
    default:
        break
    }
     return correctInput
}
