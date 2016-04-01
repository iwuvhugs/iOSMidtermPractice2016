//
//  ViewController.swift
//  MidtermPractice2016
//
//  Created by Kirill Suslov on 2016-02-29.
//  Copyright © 2016 Kirill Suslov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let formatter = NSNumberFormatter()
    
    var rotValue:Int{
        get{
            return formatter.numberFromString(rotTextField.text!)!.integerValue
        }
        set{
            rotTextField.text = formatter.stringFromNumber(newValue)
        }
    }
    
    @IBOutlet weak var originalText: UITextField!
    @IBOutlet weak var cipherText: UITextField!
    @IBOutlet weak var rotTextField: UILabel!
    
    @IBAction func cipher(sender: UIButton) {
        rotateText()
    }
    
    @IBAction func rot(sender: UISlider) {
        rotValue = Int(sender.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalText.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    let letters = NSCharacterSet.letterCharacterSet()
    func rotateText(){
        
        let original = originalText.text!
        var result = [Character]()
        
        for char in original.unicodeScalars {
            var val = UInt32(char)
            if letters.longCharacterIsMember(val){
                val +=  UInt32(rotValue)
                if !letters.longCharacterIsMember(val){
                    val -=  UInt32(26)
                }
            }
            result.append(Character(UnicodeScalar(val)))
        }
        
        cipherText.text = String(result)
    }
}

