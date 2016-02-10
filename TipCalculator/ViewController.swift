//
//  ViewController.swift
//  TipCalculator
//
//  Created by Zishi Wu on 2/7/16.
//  Copyright © 2016 Zishi Wu. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    // if user enters non-numerical text, prompt
    // user to type numerical
    @IBOutlet weak var instructions: UILabel!
    
    // needs to be checked for non-numerical text field values
    @IBOutlet weak var billAmount: UITextField!
    
    // changes according to value of the slider
    @IBOutlet weak var tipRate: UILabel!
    
    // billAmount * tipRate using NSDecimal
    @IBOutlet weak var tipAmount: UILabel!
    
    // bill amount + tipAmount using NSDecimal
    @IBOutlet weak var totalAmount: UILabel!

    @IBOutlet weak var tipRateSlider: UISlider!
    
    // changes tipRate label based on slider
    @IBAction func changeTipRate(sender: UISlider) {
        let currentTipRate = Int(sender.value)
        tipRate.text = "Tip Percentage: \(currentTipRate)%"
    }
    
    // gets bill amount and tip rate, converts to NSDecimalNumber, and calculates the tip and total
    @IBAction func calculatePay(sender: UIButton) {
        
        //NSRange range = NSMakeRange(0, [billAmount.text, length]);
        
        // first check if user entered a numerical or not
       // if !(isTextFieldNumeric(billAmount, shouldChangeCharactersInRange: range, replacementString: billAmount.text!)) {
           // billAmount.text = "Please enter a numerical value:"
       // }
        // else {
            // get decimal values of bill and tip rate
            let decimal_100 = NSDecimalNumber(string: "100.0")
            let decimal_bill = NSDecimalNumber(string: billAmount.text)
            let sliderRate = NSDecimalNumber(integer: Int(tipRateSlider.value))
            let decimal_tipRate = sliderRate.decimalNumberByDividingBy(decimal_100)
        
            // calculate decimal values for tip and total, then update labels
            let decimal_tipAmount = decimal_bill.decimalNumberByMultiplyingBy(decimal_tipRate)
            let decimal_total = decimal_bill.decimalNumberByAdding(decimal_tipAmount)
            tipAmount.text = formatAsCurrency(decimal_tipAmount)
            totalAmount.text = formatAsCurrency(decimal_total)
       // }
    }
    
    // checks if string that user inputted in billAmount text field is non-numeric,
    // returns false if so, otherwise return true
    func isTextFieldNumeric(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // Thanks to Roman Sausarnes http://stackoverflow.com/questions/27697508/nscharacterset-characterismember-with-swifts-character-type
        // need to convert characters in string to an array of unichars that can be compared to NSCharacterSet
        var codeUnits = [unichar]()
        for codeUnit in string.utf16 {
            codeUnits.append(codeUnit)
        }

        // Thanks to ndmeiri for function that checks if text is non-numeric:
        // http://stackoverflow.com/questions/30973044/how-to-restrict-uitextfield-to-take-only-numbers-in-swift?lq=1
        let digits = NSCharacterSet.decimalDigitCharacterSet()
        for c in codeUnits {
            if !digits.characterIsMember(c) {
                return false
            }
        }
        return true
    }
    
    // convert decimal number to currency format
    func formatAsCurrency(decimal_number: NSNumber) -> String {
        let formatter = NSNumberFormatter()
        formatter.locale = NSLocale.currentLocale()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        return formatter.stringFromNumber(decimal_number)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billAmount.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

