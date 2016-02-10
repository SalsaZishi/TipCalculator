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
        
        // first check if we are dealing with a number
        if let _ = Float(billAmount.text!) {
            
            if !(isValidBill(billAmount.text!)) {
                instructions.text = "Enter 1 or 2 numbers after decimal place:"
                return
            }
            let decimal_100 = NSDecimalNumber(string: "100.0")
            let decimal_bill = NSDecimalNumber(string: billAmount.text)
            let sliderRate = NSDecimalNumber(integer: Int(tipRateSlider.value))
            let decimal_tipRate = sliderRate.decimalNumberByDividingBy(decimal_100)
        
            // calculate decimal values for tip and total, then update labels
            let decimal_tipAmount = decimal_bill.decimalNumberByMultiplyingBy   (decimal_tipRate)
            let decimal_total = decimal_bill.decimalNumberByAdding(decimal_tipAmount)
            tipAmount.text = formatAsCurrency(decimal_tipAmount)
            totalAmount.text = formatAsCurrency(decimal_total)
        }
        else {
            instructions.text = "Please enter a valid numerical bill: "
        }
    }
    
    // Makes sure there are 1 or 2 numbers after the decimal place, or the number has no decimal place to begin with
    func isValidBill(bill: String) -> Bool {
        if let range: Range<String.Index> = bill.rangeOfString(".") {
            let decimal_index: Int = bill.startIndex.distanceTo(range.startIndex)
            
            // last char in string must be 1 or 2 indices after decimal place index
            let dif = (bill.characters.count - 1) - decimal_index
            if (dif == 1 || dif == 2) {
                return true
            }
            return false
        }
        // no '.'? return true
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
