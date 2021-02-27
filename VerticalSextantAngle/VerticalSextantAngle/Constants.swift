//
//  Constants.swift
//  VerticalSextantAngle
//
//  Created by pmoens on 29/12/20.
//  Copyright © 2020 pmoens. All rights reserved.
//

struct K {
    static let method1 = "Horizon and object"
    static let method2 = "Waterline and object"
    static let method3 = "Waterline and horizon"
}

struct HelpText {
    static let text = "This app will calculate the distance to an object at sea from the corrected vertical angle measurement by sextant or conversely the corrected sextant angle from the distance to the object. \n\nThere are 3 methods available depending on the conditions (N. Bowditch, LL.D. The American Practical Navigator). \n\nThe first method can be used when the object is far with the base of the object below the sea horizon and the height of the object is known. To use this method, select “Horizon and object” from the picker list. \n\nThe second method is used when the object is close with the base of the object visible and the height of the object is known. To use this method, select “Waterline and object” from the picker list. \n\nThe third method is used when the waterline of the object is visible and there is a gap between the waterline of the object and the horizon. To use this method, select “Waterline and horizon” from the picker list. \n\nFor a detailed description of these methods, see “How to Use Plastic Sextants: With Applications to Metal Sextants and a Review of Sextant Piloting” from David Burch, Starpath publications. \n\nOnce the method is selected, select the units of measurements for “Height of eye” or “ Height of object”. If the units are different between these two parameters, select the corresponding unit for one and enter the value then switch the unit and enter the value for the second parameter. \n\nIf you want to calculate the distance using the corrected sextant angle, enter the angle in degrees and minutes in the corresponding text fields \n\nIf you want to calculate the corrected sextant angle, enter the distance in nautical miles in the corresponding text field. \n\nThe height of eye is the distance between your eye when the sextant measurement is taken and the water level.\n\nThe height of the object is the distance between the waterline and the top of the object. \n\nWhen all parameters are entered in their corresponding text field, click Calculate. \n\nTo enter new value or changes values after calculation, click Reset. \nNote that changing methods will also reset all values to zero."
}
