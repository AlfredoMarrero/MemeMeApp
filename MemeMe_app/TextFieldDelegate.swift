//
//  TextFieldDelegate.swift
//  MemeMe_app
//
//  Created by Alfredo M. on 1/15/17.
//  Copyright © 2017 Alfredo. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate{

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(textField.text == "TOP" || textField.text == "BOTTOM"){
            textField.text = ""
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
