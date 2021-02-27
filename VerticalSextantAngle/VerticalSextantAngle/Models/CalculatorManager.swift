//
//  CalculatorManager.swift
//  VerticalSextantAngle
//
//  Created by pmoens on 24/11/20.
//  Copyright © 2020 pmoens. All rights reserved.
//

import UIKit

struct SextantAngle{
    var degrees: Int?
    var minutes: Int?
    var isNegative: Bool?
}

struct CalculatorManager {
    let methodArray = [K.method1, K.method2, K.method3]
    var heightOfEyes: Double = 0.0 // value stored in feet
    var objectHeight: Double = 0.0 // value stored in feet
    var distance: Double = 0.0 // value stored in nautical miles
    var selectedMethod: String = K.method1
    var sextantAngle = SextantAngle(degrees: 0, minutes: 0, isNegative: false)
    
    func metersToFeet (_ meters: Double)-> Double{
        let feet = 0.3048 // meters
        return meters / feet
    }
    
    func feetToMeters(_ feet: Double) -> Double {
        let meters = 3.28084 // feet
        return feet / meters
    }
    
    mutating func reset(){
        sextantAngle.degrees = 0
        sextantAngle.minutes = 0
        sextantAngle.isNegative = false
        heightOfEyes = 0.0
        objectHeight = 0.0
        distance = 0.0
    }
    
    mutating func calculate() {
        switch selectedMethod{
        case K.method1:
             methodOne()
        case K.method2:
             methodTwo()
        case K.method3:
             methodThree()
        default:
            break
        }
    }
    
    mutating func methodOne(){// Distance by Vertical angle measured between sea horizon and top of object beyond the sea horizon (Bowditch p560 Table 15)
        let constantOne = 0.0002419 // account for refraction
        let constantTwo = 0.7349 // account for refraction
        // the second term in the equation does not change so it is calculated outside of the if else
        let secondTerm = (objectHeight - heightOfEyes) / constantTwo
        // if distance = 0 then calculate distance
        if distance == 0.0 {
            let firstTerm = pow((tan(convertToDegree()) / constantOne), 2)
            let thirdTerm = tan(convertToDegree()) / constantOne
            self.distance = sqrt(firstTerm + secondTerm) - thirdTerm
        } else {// otherwise calculate the angle for the distance value
            //calculate tan(angle)/constantOne
            let firstTerm = (secondTerm - pow(self.distance,2)) / (2 * self.distance)
            let tanAngle = firstTerm * constantOne
            let result = atan(tanAngle).toDegrees
            convertDegreeToDegreeMinutes(result)
        }
    }
    
    mutating func methodTwo(){
        var firstTerm: Double
        let constantOne = 0.000164578833333 //converts feet in nautical miles :  5280 converts feet in miles let constantTwo = 0.86897624 // converts miles in nautical miles
        if self.distance == 0.0 { // if distance = 0 then calculate distance
            if convertToDegree() > 0 {
                firstTerm = objectHeight / tan(convertToDegree())
            } else {
                firstTerm = 0.0
            }
            self.distance = firstTerm * constantOne
        } else { // otherwise calculate the angle for the distance value
            let tanAngle = (objectHeight * constantOne) / self.distance
            let result = atan(tanAngle).toDegrees
            convertDegreeToDegreeMinutes(result)
        }
    }
    
    mutating func methodThree(){
        let beta = 0.8279 // account for terrestrial refraction
        let rZero = 3440.1 // mean radius of the earth
        //let yardConversion = 2025.3718 // converts nm into yards
        let height = heightOfEyes / 6076.1154 // converts height of eyes into nautical miles
        let firstTerm = sqrt(2 * beta * (height/rZero))
        if self.distance == 0.0 {
            let angle = tan(convertToDegree())
            let secondTerm = (angle + firstTerm) * (1 - angle * firstTerm)
            let result = (secondTerm * rZero - sqrt(pow(secondTerm * rZero, 2) - 2 * height * rZero * beta)) / beta
            self.distance = result //* yardConversion
        } else {
            let secondTerm = (height / self.distance) + ((beta * self.distance)/(2 * rZero))
            let tanAngle = (secondTerm - firstTerm)/(1 + secondTerm * firstTerm)
            let result = atan(tanAngle).toDegrees
            convertDegreeToDegreeMinutes(result)
        }
    }
    
    func convertToDegree() -> Double{ // converts the sextant angle from degrees and minutes to degrees then returns the value in radians
        let decimal = Double(sextantAngle.minutes!) / 60.0
        var angle = Double(sextantAngle.degrees!) + Double(decimal)
        if sextantAngle.isNegative!{angle = -angle}
        return Double(angle).toRadians
    }
    
    mutating func convertDegreeToDegreeMinutes(_ angle: Double){
      //convert the angle in degree to degrees and minutes that can be use for setting up the sextant
        if angle < 0 {sextantAngle.isNegative = true
        } else {sextantAngle.isNegative = false}
        sextantAngle.degrees = Int(angle)
        if let degree = sextantAngle.degrees {
            sextantAngle.minutes = Int(round(60 * (angle - Double(degree))))
        }
    }
}

var calculatorManager = CalculatorManager()

extension Double{
    var toRadians: Double{ return self * .pi / 180 }
    var toDegrees: Double{ return self * 180 / .pi}
}
