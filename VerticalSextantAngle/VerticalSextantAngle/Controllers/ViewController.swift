//
//  ViewController.swift
//  VerticalSextantAngle
//
//  Created by pmoens on 24/11/20.
//  Copyright © 2020 pmoens. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var methodPicker: UIPickerView!
    @IBOutlet weak var degreeText: UITextField!
    @IBOutlet weak var minuteText: UITextField!
    @IBOutlet weak var heightOfEyeText: UITextField!
    @IBOutlet weak var heightOfEyeLabel: UILabel!
    
    @IBOutlet weak var objectHeightText: UITextField!
    @IBOutlet weak var objectHeightLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var distanceText: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    
    @IBOutlet weak var unitSwitch: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        methodPicker.delegate = self
        methodPicker.dataSource = self
        degreeText.delegate = self
        minuteText.delegate = self
        heightOfEyeText.delegate = self
        objectHeightText.delegate = self
    }

    @IBAction func unitSwitch(_ sender: UISegmentedControl) {
       // switch values from metric to imperial
        switch unitSwitch.selectedSegmentIndex{
        case 0: // meters
            heightOfEyeLabel.text = "Height of eye (m)"
            objectHeightLabel.text = "Height of object (m)"
            heightOfEyeText.text = String(format: "%.1f", calculatorManager.feetToMeters(calculatorManager.heightOfEyes))
            objectHeightText.text = String(format: "%.1f", calculatorManager.feetToMeters(calculatorManager.objectHeight))
            inFeet = false
        case 1: // feet
            heightOfEyeLabel.text = "Height of eye (ft)"
            objectHeightLabel.text = "Height of object (ft)"
            heightOfEyeText.text = String(format: "%.1f", calculatorManager.heightOfEyes)
            objectHeightText.text = String(format: "%.1f", calculatorManager.objectHeight)
            inFeet = true
        default:
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if degreeText.isFirstResponder {updateTextField(degreeText)}
        else if minuteText.isFirstResponder{updateTextField(minuteText)}
        else if heightOfEyeText.isFirstResponder{updateTextField(heightOfEyeText)}
        else if objectHeightText.isFirstResponder{updateTextField(objectHeightText)}
        else if distanceText.isFirstResponder{updateTextField(distanceText)}
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if sender.currentTitle! == "C"{
            calculatorManager.calculate()
            distanceText.text = String(format: "%.2f", calculatorManager.distance )
            var signString: String = ""
            if calculatorManager.sextantAngle.isNegative! {signString = "-"}
            degreeText.text = signString + String(format: "%01d", calculatorManager.sextantAngle.degrees ?? "0")
            minuteText.text = String(format: "%01d", calculatorManager.sextantAngle.minutes ?? "0")
            sender.isEnabled = false
            disableInput()
        } else {
            reset()
        }
        
    }
    
    func reset(){
        calculatorManager.reset()
        calculateButton.isEnabled = true
        enableInput()
        zeroedTextField()
    }
    
    func zeroedTextField(){
        degreeText.text = "0"
        minuteText.text = "0"
        heightOfEyeText.text = "0.0"
        objectHeightText.text = "0.0"
        distanceText.text = "0.00"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       calculatorManager.selectedMethod = calculatorManager.methodArray[row]
        // disable text box and labels depending on method selected
        selectInput()
        reset()
    }
    func enableInput(){
        degreeText.isEnabled = true
        minuteText.isEnabled = true
        heightOfEyeText.isEnabled = true
        objectHeightText.isEnabled = true
        distanceText.isEnabled = true
        
    }
    func disableInput(){
        degreeText.isEnabled = false
        minuteText.isEnabled = false
        heightOfEyeText.isEnabled = false
        objectHeightText.isEnabled = false
        distanceText.isEnabled = false
    }
    
    func selectInput(){
        switch calculatorManager.selectedMethod{
        case K.method1:
            heightOfEyeLabel.isHidden = false
            heightOfEyeText.isHidden = false
            objectHeightLabel.isHidden = false
            objectHeightText.isHidden = false
            
        case K.method2:
            heightOfEyeText.isHidden = true
            heightOfEyeLabel.isHidden = true
            objectHeightLabel.isHidden = false
            objectHeightText.isHidden = false
            
        case K.method3:
            heightOfEyeLabel.isHidden = false
            heightOfEyeText.isHidden = false
            objectHeightLabel.isHidden = true
            objectHeightText.isHidden = true
        default:
            break
        }
    }
 
    
    
    
}




//MARK: - PickerViewDelegate
extension UIViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return calculatorManager.methodArray.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return calculatorManager.methodArray[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        NSAttributedString(string: calculatorManager.methodArray[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
}

//MARK: - TextFieldDelegate
extension UIViewController: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.endEditing(true)
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        updateTextField(textField)
    }
    
    @IBAction func textChange(_ sender: UITextField) {
        if !checkUserInput(sender){sender.text = ""}
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string == string.filter("-0123456789.".contains)
    }
}
